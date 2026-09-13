---
title: Reverse Proxy & TLS
icon: lucide/network
---

# Reverse Proxy & TLS :material-network:{ .main-color }

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Automatic HTTPS</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> Caddy</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg> Traefik</span>

In production and homelab environments, placing an edge reverse proxy in front of CloudRader containers provides automatic SSL/TLS certificate generation, subdomain routing, and unified ingress security.

---

## :material-shield-check: Why Use a Reverse Proxy?

<div class="grid cards" markdown>

-   :material-lock-check:{ .main-color } __Automatic HTTPS__

    ---

    Automatically obtain and renew free Let\'s Encrypt or ZeroSSL TLS certificates with zero manual intervention.

-   :material-routes:{ .main-color } __Subdomain Routing__

    ---

    Map friendly domain names (`reservium.example.com`, `auth.example.com`) to internal container ports on ports 80 and 443.

-   :material-wall:{ .main-color } __Port Isolation__

    ---

    Keep internal database and application ports (5432, 8000, 8080) hidden from the public internet.

-   :material-speedometer:{ .main-color } __Compression & Performance__

    ---

    Enable modern HTTP/2, HTTP/3, and Gzip/Zstandard compression on all outbound web requests.

</div>

---

## :material-check-decagram: Recommended Option: Caddy

**[Caddy](https://caddyserver.com)** is the recommended reverse proxy for CloudRader self-hosters due to its clean syntax and zero-configuration HTTPS automation.

### 1. Example `Caddyfile`

Create a `Caddyfile` alongside your `compose.yaml`:

```caddy
# ==============================================================================
# CloudRader Reference Caddyfile
# ==============================================================================

# Identity Provider (Keycloak Reference)
auth.example.com {
    reverse_proxy keycloak:8080 {
        header_up X-Forwarded-Proto https
        header_up X-Forwarded-Host {host}
        header_up X-Forwarded-Port 443
    }
}

# Reservium Web User Interface
reservium.example.com {
    reverse_proxy reservium-ui:80
}

# Reservium REST API
api.reservium.example.com {
    reverse_proxy reservium-api:8000
}

# Inventarium REST API
api.inventarium.example.com {
    reverse_proxy inventarium-api:8080
}

# Central Documentation Portal
docs.example.com {
    reverse_proxy docs:8000
}
```

### 2. Adding Caddy to Docker Compose

Add the Caddy service to your `compose.yaml`:

```yaml
services:
  caddy:
    image: caddy:2-alpine
    container_name: cloudrader-caddy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp" # HTTP/3 Support
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile:ro
      - caddy_data:/data
      - caddy_config:/config
    networks:
      - cloudrader-net

volumes:
  caddy_data:
  caddy_config:
```

---

## :material-server-network: Alternative: Traefik

If your infrastructure uses **Traefik**, attach routing labels directly to your service definitions in `compose.yaml`:

```yaml
services:
  reservium-ui:
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.reservium.rule=Host(`reservium.example.com`)"
      - "traefik.http.routers.reservium.entrypoints=websecure"
      - "traefik.http.routers.reservium.tls.certresolver=letsencrypt"

  reservium-api:
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.reservium-api.rule=Host(`api.reservium.example.com`)"
      - "traefik.http.routers.reservium-api.entrypoints=websecure"
      - "traefik.http.routers.reservium-api.tls.certresolver=letsencrypt"

  inventarium-api:
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.inventarium-api.rule=Host(`api.inventarium.example.com`)"
      - "traefik.http.routers.inventarium-api.entrypoints=websecure"
      - "traefik.http.routers.inventarium-api.tls.certresolver=letsencrypt"
```

---

## :material-alert-circle-outline: Important Proxy Headers

Identity providers (such as Keycloak) and FastAPI require accurate proxy headers to prevent redirect loops and CORS failures:

| Header | Required Value | Purpose |
| :--- | :--- | :--- |
| `X-Forwarded-Proto` | `https` | Informs backend services that the client connection is encrypted. |
| `X-Forwarded-Host` | `{host}` (e.g., `auth.example.com`) | Preserves the client-requested hostname for OAuth2 redirect generation. |
| `X-Forwarded-For` | `{remote_host}` | Passes client IP address for security logging and rate-limiting. |
| `X-Forwarded-Port` | `443` | Confirms default HTTPS port for callback validation. |

---

## :material-format-list-checks: Pre-Flight DNS & Firewall Checklist

Before starting your reverse proxy:

1. **DNS Records**: Create `A` (or `AAAA`) records for all desired subdomains (`auth.example.com`, `reservium.example.com`) pointing to your server\'s public IP.
2. **Port Forwarding**: Ensure ports **80** (HTTP verification) and **443** (HTTPS traffic) are open on your router, firewall, or cloud security group.
3. **Verify Certificate**: Once Caddy starts, test certificate issuance in your browser or with:
   ```bash
   curl -I https://reservium.example.com
   ```
