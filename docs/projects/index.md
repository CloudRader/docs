---
title: Projects
icon: lucide/layout-grid
---

# CloudRader Projects :material-view-grid-outline:{ .main-color }

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Modular</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> Self-Hostable</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg> Open Standards</span>

The **CloudRader** ecosystem is composed of single-purpose, autonomous services designed to run standalone or integrate seamlessly together in homelabs, organizations, and team infrastructure. Each tool maintains its own isolated database while sharing unified OpenID Connect authentication.

---

## :material-view-grid-outline: Active & Planned Services

<div class="grid cards" markdown>

-   :material-calendar-check:{ .reservium-color } __[Reservium](reservium/index.md)__

    ---

    <span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line><path d="m9 16 2 2 4-4"></path></svg> Reservium</span>
    <span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Production Ready</span>

    A comprehensive room, space, and shared resource reservation system with interactive calendar scheduling, manager approvals, and OpenID Connect (OIDC) SSO.

    <span class="tech-tag">Python</span> <span class="tech-tag">FastAPI</span> <span class="tech-tag">React</span> <span class="tech-tag">PostgreSQL</span> <span class="tech-tag">OIDC</span> <span class="tech-tag">Docker</span>

    [:material-arrow-right: Project Overview](reservium/index.md) · [:material-open-in-new: Live Docs](https://docs.reservium.cloudrader.com) · [:fontawesome-brands-github: GitHub](https://github.com/CloudRader/reservium-api)

-   :material-package-variant-closed:{ .inventarium-color } __[Inventarium](inventarium/index.md)__

    ---

    <span class="badge badge-purple"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg> Inventarium</span>
    <span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg> In Development</span>

    A lightweight organizational asset and equipment lifecycle tracking system for custody tracking, hierarchical locations, and QR labels.

    <span class="tech-tag">Kotlin</span> <span class="tech-tag">Spring Boot</span> <span class="tech-tag">PostgreSQL</span> <span class="tech-tag">OIDC</span> <span class="tech-tag">Docker</span>

    [:material-arrow-right: Project Overview](inventarium/index.md) · [:fontawesome-brands-github: GitHub API](https://github.com/CloudRader/inventarium-api)

</div>

---

## :material-table: Service Comparison Matrix

| Service | Primary Domain | Technology Stack | Status | Documentation | Source Code |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **[Reservium](reservium/index.md)** | Rooms & Shared Space Scheduling | Python, FastAPI, React, PostgreSQL | `Production Ready` | [docs.reservium.cloudrader.com :material-open-in-new:](https://docs.reservium.cloudrader.com) | [GitHub :fontawesome-brands-github:](https://github.com/CloudRader/reservium-api) |
| **[Inventarium](inventarium/index.md)** | Equipment & Asset Lifecycle Tracking | Kotlin, Spring Boot, PostgreSQL | `In Development` | [Project Overview](inventarium/index.md) | [GitHub :fontawesome-brands-github:](https://github.com/CloudRader/inventarium-api) |

---

## :material-puzzle-check-outline: Why Modular Services?

Traditional enterprise suites force organizations into monolithic systems where everything is tightly coupled. CloudRader follows a modern decentralized model:

<div class="grid cards" markdown>

-   :material-tune-vertical:{ .main-color } __Pick What You Need__

    ---

    Deploy Reservium today without needing any other CloudRader service. No unwanted dependencies, bloat, or background resource drain.

-   :material-update:{ .main-color } __Independent Upgrades__

    ---

    Upgrade, scale, or restart one service without database locks, schema conflicts, or downtime across the rest of your organization.

-   :material-shield-key-outline:{ .main-color } __Unified Identity (SSO)__

    ---

    Connect services through shared OpenID Connect (OIDC) authentication for effortless single sign-on across all applications.

-   :material-code-json:{ .main-color } __API-First Open Standards__

    ---

    Every service exposes documented REST APIs with OpenAPI specifications, making scripting, custom dashboards, and automation straightforward.

</div>

---

## :material-rocket-launch-outline: Deployment & Quickstart

!!! info "Deploy with Docker Compose"
    Want to run CloudRader services in your homelab or organization? All services can be deployed together with automated identity provider SSO via our reference Docker Compose stack.

    Read the **[Unified Quickstart Stack Guide](../hosting/quickstart-stack.md)** to get started in minutes.
