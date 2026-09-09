---
icon: lucide/network
---

# Ecosystem Architecture :material-puzzle-outline:{ .main-color }

CloudRader is designed as a modular ecosystem of independent, self-hostable tools that solve common organizational workflows. Rather than building a large monolithic platform, CloudRader focuses on loosely coupled services that work well individually and even better together.

---

## :material-puzzle-outline: Core Architectural Principles

### 1. Independent & Self-Contained Services

Every application in the CloudRader ecosystem operates as an autonomous service:

- Services do not share databases; each tool manages its own persistence layer.
- Failure of one service (e.g., asset tracking) does not disrupt another (e.g., room reservations).
- Each service can be deployed, scaled, or upgraded independently.

### 2. Unified Identity & Single Sign-On

While services are independently deployed, user authentication is unified:

- All CloudRader services support **OpenID Connect (OIDC)** authentication.
- CloudRader is **identity provider agnostic**—services integrate seamlessly with any OIDC-compliant provider (such as Keycloak, Authentik, Authelia, or Zitadel).
- Users authenticate once and access all permitted CloudRader services seamlessly.

### 3. API-First Design

Every capability available in CloudRader user interfaces is backed by a well-defined HTTP API:

- Standardized RESTful endpoints with OpenAPI 3.0 specifications.
- Clear error structures and predictable JSON responses.
- Enables automation, CLI integrations, and custom workflow tooling.

### 4. Container-Native & 12-Factor Ready

- Distributed as lightweight, rootless Docker container images.
- Configured strictly through environment variables and standard `.env` files.
- Persistent data is isolated to explicit volumes for straightforward backups.

---

## :material-layers-outline: Layered Architecture

The CloudRader architecture is structured across four primary layers:

```
[ Clients: Web & Mobile ]
           │
           ▼
[ Edge Layer: Reverse Proxy & TLS (Caddy / Traefik) ]
     │                              │
     ▼                              ▼
[ Identity: Provider (OIDC) ]    [ Application: Reservium / Inventarium ]
     │                              │
     ▼                              ▼
[ Auth DB: PostgreSQL ]          [ App DB: PostgreSQL ]
```

1. **Edge Layer**: Reverse proxy (Caddy, Traefik, or Nginx) handling SSL termination, domain routing, and certificate management.
2. **Identity Layer**: Any standard OpenID Connect (OIDC) identity provider managing user accounts, permissions, and access tokens.
3. **Application Layer**: CloudRader microservices (Reservium, Inventarium) handling domain business logic.
4. **Data Layer**: Persistent PostgreSQL databases with service-specific schemas or instances.
