---
title: Quickstart Stack
icon: lucide/layers
---

# Unified Quickstart Stack :material-layers-outline:{ .main-color }

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Docker Compose</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> Multi-Service Ecosystem</span>
<span class="badge badge-purple"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg> Unified SSO</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1 4-10z"></path></svg> Production Ready</span>

This guide walks through deploying the complete **CloudRader ecosystem stack** using Docker Compose. The stack orchestrates central single sign-on (SSO), shared relational database infrastructure, and modular application services (**Reservium** for room & space scheduling, and **Inventarium** for equipment tracking).

!!! tip "Deploying Reservium Standalone?"
    If you only need room & calendar booking without running other CloudRader services or the central ecosystem stack, refer directly to the **[Reservium Standalone Hosting Guide :material-open-in-new:](https://docs.reservium.cloudrader.com/hosting-guide/introduction/)**.

    This guide focuses on the **organization-wide deployment** where multiple CloudRader services run together, sharing central authentication and database infrastructure.

---

## :material-layers-outline: Stack Architecture & Modularity

The CloudRader ecosystem follows a decoupled, modular architecture:

<div class="grid cards" markdown>

-   :material-database:{ .main-color } __Shared Database Infrastructure__

    ---

    A single PostgreSQL 16 instance maintains isolated databases (`keycloak`, `reservium`, `inventarium`), ensuring clean data separation with minimal resource overhead.

-   :material-shield-key:{ .main-color } __Central Single Sign-On (SSO)__

    ---

    An OpenID Connect (OIDC) identity provider (Keycloak reference implementation) authenticates users once for all ecosystem services.

-   :material-calendar-check:{ .reservium-color } __Reservium (Bookings & Spaces)__

    ---

    FastAPI backend and React UI for meeting room bookings, desk reservations, calendar views, and manager approvals.

-   :material-package-variant-closed:{ .inventarium-color } __Inventarium (Asset Management)__

    ---

    Kotlin / Spring Boot backend service for equipment custody, check-in/check-out tracking, and hardware lifecycle management.

</div>

---

## :material-numeric-1-box-outline: Step 1. Project Directory & Configuration

Create a dedicated directory for your deployment:

```bash
mkdir -p /opt/cloudrader && cd /opt/cloudrader
```

### 1. Environment Variables (`.env`)

Create an `.env` file containing your deployment configuration. Replace the placeholder passwords with strong secrets:

```bash
# ==============================================================================
# CloudRader Ecosystem Configuration
# ==============================================================================

# Shared PostgreSQL Database
POSTGRES_USER=cloudrader
POSTGRES_PASSWORD=generate_a_secure_database_password_here
POSTGRES_DB=cloudrader

# Central Identity Provider (Keycloak Reference Implementation)
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=generate_a_secure_admin_password_here
KEYCLOAK_DB=keycloak

# Reservium Service Secrets
RESERVIUM_CLIENT_SECRET=generate_a_secure_reservium_secret_here

# Inventarium Service Secrets
INVENTARIUM_CLIENT_SECRET=generate_a_secure_inventarium_secret_here
```

!!! tip "Generating Secure Passwords"
    You can quickly generate cryptographically strong passwords with `openssl`:
    ```bash
    openssl rand -base64 24
    ```

### 2. Database Initialization Script (`init-db.sh`)

Because PostgreSQL initializes with a single default database, create a lightweight initialization script to automatically create isolated databases for each service on first boot:

```bash
cat << 'EOF' > init-db.sh
#!/bin/sh
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE keycloak;
    CREATE DATABASE reservium;
    CREATE DATABASE inventarium;
EOSQL
EOF
chmod +x init-db.sh
```

---

## :material-numeric-2-box-outline: Step 2. Docker Compose Configuration

Create `compose.yaml` (or `docker-compose.yml`) in the same directory:

```yaml
services:
  # ============================================================================
  # Core Infrastructure Tier
  # ============================================================================
  postgres:
    image: postgres:16-alpine
    container_name: cloudrader-postgres
    restart: unless-stopped
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      timeout: 5s
      retries: 5
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init-db.sh:/docker-entrypoint-initdb.d/01-init-databases.sh:ro
    networks:
      - cloudrader-net

  keycloak:
    image: quay.io/keycloak/keycloak:26.4
    container_name: cloudrader-keycloak
    restart: unless-stopped
    command: start-dev
    environment:
      KC_DB: postgres
      KC_DB_URL: jdbc:postgresql://postgres:5432/${KEYCLOAK_DB}
      KC_DB_USERNAME: ${POSTGRES_USER}
      KC_DB_PASSWORD: ${POSTGRES_PASSWORD}
      KEYCLOAK_ADMIN: ${KEYCLOAK_ADMIN}
      KEYCLOAK_ADMIN_PASSWORD: ${KEYCLOAK_ADMIN_PASSWORD}
    ports:
      - "8443:8080"
    depends_on:
      postgres:
        condition: service_healthy
    networks:
      - cloudrader-net

  # ============================================================================
  # Application Services: Reservium (Room & Space Booking)
  # ============================================================================
  reservium-api:
    image: ghcr.io/cloudrader/reservium-api:latest
    container_name: cloudrader-reservium-api
    restart: unless-stopped
    environment:
      DATABASE_URL: postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/reservium
      KEYCLOAK__SERVER_URL: http://keycloak:8080
      KEYCLOAK__REALM: cloudrader
      KEYCLOAK__CLIENT_ID: reservium-app
      KEYCLOAK__CLIENT_SECRET: ${RESERVIUM_CLIENT_SECRET}
    ports:
      - "8000:8000"
    depends_on:
      postgres:
        condition: service_healthy
      keycloak:
        condition: service_started
    networks:
      - cloudrader-net

  reservium-ui:
    image: ghcr.io/cloudrader/reservium-ui:latest
    container_name: cloudrader-reservium-ui
    restart: unless-stopped
    ports:
      - "3000:80"
    depends_on:
      - reservium-api
    networks:
      - cloudrader-net

  # ============================================================================
  # Application Services: Inventarium (Asset & Equipment Tracking)
  # ============================================================================
  inventarium-api:
    image: ghcr.io/cloudrader/inventarium-api:latest
    container_name: cloudrader-inventarium-api
    restart: unless-stopped
    environment:
      POSTGRES_HOST: postgres
      POSTGRES_PORT: 5432
      POSTGRES_DB: inventarium
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      OIDC_ISSUER_URI: http://keycloak:8080/realms/cloudrader
      OIDC_CLIENT_ID: inventarium-app
      OIDC_CLIENT_SECRET: ${INVENTARIUM_CLIENT_SECRET}
    ports:
      - "8010:8080"
    depends_on:
      postgres:
        condition: service_healthy
      keycloak:
        condition: service_started
    networks:
      - cloudrader-net

volumes:
  postgres_data:

networks:
  cloudrader-net:
    driver: bridge
```

---

## :material-numeric-3-box-outline: Step 3. Launching & Operating the Stack

Start all containers in detached mode:

```bash
docker compose up -d
```

### Selective / Modular Deployments

Because CloudRader services are autonomous, you can choose to run only the services your organization currently needs. For instance, to start only the core infrastructure and Reservium:

```bash
docker compose up -d postgres keycloak reservium-api reservium-ui
```

Check the health and runtime status of running containers:

```bash
docker compose ps
```

To stream live logs across all services:

```bash
docker compose logs -f
```

---

## :material-web: Step 4. Accessing Your Services

Once container startup finishes, access your ecosystem endpoints:

| Service | Local Endpoint | Function & Default Access |
| :--- | :--- | :--- |
| **Central Identity (Keycloak)** | [http://localhost:8443](http://localhost:8443) | Organization SSO, user accounts, and OIDC client secrets |
| **Reservium Web Interface** | [http://localhost:3000](http://localhost:3000) | Room booking calendar for team members and space managers |
| **Reservium API Docs (Swagger)** | [http://localhost:8000/docs](http://localhost:8000/docs) | Interactive OpenAPI 3.0 documentation for reservations |
| **Inventarium API Docs (Swagger)** | [http://localhost:8010/swagger-ui.html](http://localhost:8010/swagger-ui.html) | OpenAPI documentation for asset & equipment tracking |

---

## :material-shield-alert-outline: Production Security Checklist

!!! warning "Recommended Hardening for Production"
    - **Keep `.env` Private**: Never commit `.env` to version control.
    - **Change Default Passwords**: Ensure all database and admin credentials use strong random secrets.
    - **Use a Reverse Proxy**: Do not expose container ports directly to the internet. Terminate HTTPS and route subdomains with **[Caddy or Traefik](reverse-proxy.md)**.
    - **Isolated OIDC Clients**: Configure separate client credentials in your Identity Provider for each application service (e.g., `reservium-app` and `inventarium-app`).

---

## :material-arrow-right-circle: Next Steps

- Set up SSO realms, users, and client secrets in the **[Identity Provider Guide](identity-provider.md)**.
- Terminate HTTPS and configure subdomain routing with **[Reverse Proxy & TLS](reverse-proxy.md)**.
- Automate nightly database snapshots and volume backups with **[Backup & Maintenance](backup-restore.md)**.
- For standalone Reservium setup, see the **[Reservium Dedicated Documentation :material-open-in-new:](https://docs.reservium.cloudrader.com/hosting-guide/)**.
