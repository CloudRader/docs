---
title: Self-Hosting
icon: lucide/server
---

# Self-Hosting CloudRader :material-server-network:{ .main-color }

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Docker Compose</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> Self-Hostable</span>
<span class="badge badge-purple"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg> Identity Provider (SSO)</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg> Data Sovereignty</span>

The **CloudRader** ecosystem is built from the ground up for self-hosting. Whether running on a homelab server, a modest VPS, or organizational infrastructure, CloudRader gives you full sovereignty over your operational data, access controls, and retention policies.

---

## :material-map: Explore the Hosting Guides

<div class="grid cards" markdown>

-   :material-layers-outline:{ .main-color } __[Quickstart Stack](quickstart-stack.md)__

    ---

    Deploy the complete multi-service ecosystem stack running an Identity Provider, PostgreSQL, Reservium, and Inventarium with Docker Compose.

-   :material-shield-key-outline:{ .main-color } __[Identity Provider & SSO](identity-provider.md)__

    ---

    Configure central authentication, realm permissions, and OpenID Connect (OIDC) client credentials with Keycloak as the reference example.

-   :material-network:{ .main-color } __[Reverse Proxy & TLS](reverse-proxy.md)__

    ---

    Route subdomains and manage automated SSL/TLS certificates using Caddy or Traefik.

-   :material-database-sync-outline:{ .main-color } __[Backup & Maintenance](backup-restore.md)__

    ---

    Perform automated PostgreSQL snapshots, volume archiving, zero-downtime updates, and disaster recovery.

</div>

---

## :material-sitemap: Self-Hosted Architecture

All CloudRader services follow a layered, decoupled deployment pattern:

``` mermaid
flowchart TD
    Clients["Clients and Browsers"]

    subgraph Ingress["Edge Ingress Layer"]
        Proxy["Reverse Proxy: Caddy or Traefik<br/>Ports 80 and 443 with TLS"]
    end

    subgraph Auth["Identity and Access Management"]
        IdP["Identity Provider: OIDC and SSO<br/>Keycloak or Authentik or Authelia"]
    end

    subgraph Services["Modular Application Services"]
        Reservium["Reservium<br/>Web UI and REST API"]
        Inventarium["Inventarium<br/>REST API Backend"]
    end

    subgraph Storage["Data Persistence Layer"]
        DB[("PostgreSQL 16 Engine<br/>Isolated Service Databases")]
    end

    Clients -->|"HTTPS 443"| Proxy
    Proxy -->|"auth domain"| IdP
    Proxy -->|"reservium domain"| Reservium
    Proxy -->|"inventarium domain"| Inventarium

    Reservium -.->|"Validate JWT"| IdP
    Inventarium -.->|"Validate JWT"| IdP

    IdP -->|"Auth DB"| DB
    Reservium -->|"Reservium DB"| DB
    Inventarium -->|"Inventarium DB"| DB
```

1. **Ingress & TLS**: A reverse proxy terminates HTTPS, provides certificates via Let\'s Encrypt, and routes subdomains to internal container ports.
2. **Unified Identity**: An OpenID Connect (OIDC) identity provider (such as Keycloak, Authentik, or Authelia) manages user credentials, single sign-on, and role tokens across all applications.
3. **Application Tier**: Autonomous, modular service containers (Reservium for bookings, Inventarium for assets) that plug into the shared identity and data layer.
4. **Data Isolation**: PostgreSQL with independent databases per service, ensuring zero cross-application database locks.

---

## :material-tune-vertical: System Requirements

CloudRader services are designed to be resource-efficient:

| Component | Minimum (Testing & Homelab) | Recommended (Production / Teams) |
| :--- | :--- | :--- |
| **CPU** | 2 vCPUs | 4 vCPUs |
| **Memory** | 2 GB RAM | 4 GB - 8 GB RAM |
| **Disk Space** | 20 GB SSD | 50+ GB SSD (based on uploads & backups) |
| **Operating System** | Linux (Ubuntu, Debian, Fedora, Arch) | Linux (Ubuntu 24.04 LTS or Debian 12) |
| **Runtime** | Docker Engine 24+ & Docker Compose v2 | Docker Engine 26+ & Docker Compose v2 |

---

## :material-check-decagram-outline: Core Hosting Tenets

- **12-Factor Configuration**: Every setting is configured via standard environment variables and `.env` files.
- **Rootless & Secure**: Containers are designed to run with minimal privileges without requiring host root access.
- **Independent Lifecycles**: Update or restart individual application services without disrupting identity or database operations.
- **Portable Persistence**: All databases and application state reside in named Docker volumes for easy backups.

---

## :material-rocket-launch: Ready to Deploy?

Get your server running in less than five minutes with our **[Unified Quickstart Stack Guide](quickstart-stack.md)**.
