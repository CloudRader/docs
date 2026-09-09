---
title: Reservium
icon: lucide/calendar-check-2
---

# Reservium :material-calendar-check:{ .reservium-color }

<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line><path d="m9 16 2 2 4-4"></path></svg> Reservium</span>
<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Production Ready</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> Self-Hostable</span>

**Reservium** is CloudRader's flagship reservation and space management platform. Designed from the ground up for organizations, educational spaces, coworking environments, and homelab teams, Reservium replaces fragmented spreadsheets and calendar invites with a unified, self-hosted booking system.

---

## :material-star-outline: Key Capabilities

<div class="grid cards" markdown>

-   :material-calendar-month:{ .reservium-color } __Visual Scheduling__

    ---

    Clear day, week, and month views of availability, upcoming events, time slots, and automatic conflict detection.

-   :material-account-supervisor:{ .reservium-color } __Role-Based Workflows__

    ---

    Granular permissions separating regular users (browse & book), managers (review & approve requests), and administrators.

-   :material-key-chain:{ .reservium-color } __Single Sign-On (SSO)__

    ---

    Native OpenID Connect (OIDC) integration. Connect with any compliant identity provider (such as Keycloak, Authentik, or Authelia) and synchronize user profile roles automatically.

-   :material-api:{ .reservium-color } __OpenAPI 3.0 REST Backend__

    ---

    High-performance async API powered by FastAPI with interactive Swagger UI documentation and standardized JSON schemas.

</div>

---

## :material-code-tags: Technical Architecture & Stack

Reservium is decoupled into an asynchronous Python API backend and a responsive React frontend:

<div class="tech-tags">
  <span class="tech-tag">Python 3.12+</span>
  <span class="tech-tag">FastAPI</span>
  <span class="tech-tag">SQLAlchemy 2.0</span>
  <span class="tech-tag">React</span>
  <span class="tech-tag">PostgreSQL 16</span>
  <span class="tech-tag">Alembic</span>
  <span class="tech-tag">OIDC</span>
  <span class="tech-tag">Docker Compose</span>
</div>

- **Backend Service**: Built with FastAPI, SQLAlchemy 2.0 async sessions, Alembic database migrations, and Pydantic v2 data validation.
- **Frontend Dashboard**: Responsive calendar and booking interface built with React, Vite, and modern styling components.
- **Data Isolation**: Fully independent PostgreSQL database with schema migrations managed per release.
- **Container Packaging**: Multi-stage, rootless Docker images ready for Docker Compose or Kubernetes deployment.

---

## :material-folder-open-outline: Project Repositories

| Component | Repository | Description | Technology | Source |
| :--- | :--- | :--- | :--- | :--- |
| **API Backend** | `CloudRader/reservium-api` | Core FastAPI backend service, database models, and migration scripts | Python / FastAPI / PostgreSQL | [GitHub :fontawesome-brands-github:](https://github.com/CloudRader/reservium-api) |
| **Web UI** | `CloudRader/reservium-ui` | Frontend client interface, interactive calendar, and manager dashboard | React / Vite / Tailwind | [GitHub :fontawesome-brands-github:](https://github.com/CloudRader/reservium-ui) |
| **Documentation** | `CloudRader/reservium-docs` | Comprehensive user manual, manager guide, and API reference | Zensical / Markdown | [GitHub :fontawesome-brands-github:](https://github.com/CloudRader/reservium-docs) |

---

## :material-book-open-outline: Dedicated Documentation Portal

!!! tip "Full Documentation Hub: docs.reservium.cloudrader.com"
    Reservium maintains its own dedicated, detailed documentation site for end users, managers, and self-hosters:

    - **[User Guide :material-open-in-new:](https://docs.reservium.cloudrader.com/user-guide/quickstart/)**: How to explore calendars, reserve resources, and manage personal bookings.
    - **[Manager Guide :material-open-in-new:](https://docs.reservium.cloudrader.com/manager-guide/manager-panel/)**: How to approve reservation requests, configure calendars, and define service policies.
    - **[API Reference :material-open-in-new:](https://docs.reservium.cloudrader.com/api-reference/)**: Complete interactive REST endpoint reference and OpenAPI specification.
    - **[Deploy with CloudRader](../../hosting/quickstart-stack.md)**: Deploy Reservium alongside a central identity provider in the unified Docker Compose stack.
