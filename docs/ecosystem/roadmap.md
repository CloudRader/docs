---
icon: lucide/map
---

# Ecosystem Roadmap :material-flag-checkered:{ .main-color }

This roadmap outlines the past, current, and upcoming development milestones across the CloudRader organization and its core services.

---

## :material-flag-checkered: Current Status

- **Reservium MVP**: Core space and room reservation system with visual calendar, manager controls, and OIDC support.
- **Central Documentation**: Unified documentation hub establishing standards, architecture, and deployment patterns.
- **Single Sign-On Standard**: Defined Keycloak integration baseline across current and future services.

---

## :material-clock-fast: Near-Term Goals

### 1. Inventarium (Asset & Equipment Management)
- Finalize domain model for organizational assets, equipment check-in/check-out, and custody tracking.
- Scaffold FastAPI backend with PostgreSQL and Alembic migrations.
- Develop modern web UI for asset browsing and QR code generation.

### 2. Unified Self-Hosting Stack
- Reference Docker Compose setup running Keycloak, PostgreSQL, and Reservium with one command.
- Automated Keycloak realm import scripts for effortless first-time setups.
- Healthcheck orchestration and container restart policies.

### 3. Shared Design System & Components
- Reusable UI component library for consistent styling across CloudRader web applications.
- Shared dark/light theme tokens and accessibility patterns.

---

## :material-telescope: Long-Term Vision

- **Cross-Service Workflows**: Linking Reservium room bookings with Inventarium equipment reservations.
- **Unified Notification Gateway**: Central service for email, webhook, and push notifications across all apps.
- **Kubernetes & Helm Support**: Production-grade Helm charts for high-availability deployments.
