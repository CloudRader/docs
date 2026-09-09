---
title: Inventarium
icon: lucide/package
---

# Inventarium :material-package-variant-closed:{ .inventarium-color }

<span class="badge badge-purple"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg> Inventarium</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg> In Development</span>
<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Open Source</span>

**Inventarium** is an upcoming open-source asset management and equipment lifecycle tracking system in the CloudRader ecosystem. Built for teams, homelabs, makerspaces, and organizations, Inventarium provides full custody visibility, location tracking, and maintenance records for physical hardware and tools.

---

## :material-target: Core Capabilities

<div class="grid cards" markdown>

-   :material-account-check:{ .inventarium-color } __Custody & Check-In/Out__

    ---

    Track who holds each piece of equipment, expected return dates, check-out histories, and automated reminders for overdue items.

-   :material-file-tree:{ .inventarium-color } __Hierarchical Locations__

    ---

    Organize organizational assets spatially across campuses, buildings, rooms, equipment racks, shelves, and storage bins.

-   :material-qrcode-scan:{ .inventarium-color } __QR & Barcode Labeling__

    ---

    Generate printable labels to rapidly scan, audit, and look up asset records on-site with mobile devices.

-   :material-calendar-sync:{ .inventarium-color } __Reservium Integration__

    ---

    Coordinated reservation flows: reserve meeting rooms in Reservium while automatically provisioning required equipment in Inventarium.

</div>

---

## :material-code-tags: Technical Architecture & Stack

Inventarium leverages Kotlin and Spring Boot for a robust, enterprise-grade backend service:

<div class="tech-tags">
  <span class="tech-tag">Kotlin</span>
  <span class="tech-tag">Spring Boot</span>
  <span class="tech-tag">Spring Data JPA</span>
  <span class="tech-tag">PostgreSQL</span>
  <span class="tech-tag">Liquibase</span>
  <span class="tech-tag">OIDC</span>
  <span class="tech-tag">Docker Compose</span>
</div>

- **Backend Service**: Built with Kotlin, Spring Boot 3, Spring Data JPA, and Gradle.
- **Database Migrations**: Managed declaratively through Liquibase change logs.
- **Identity & Security**: Authenticates via standard OAuth2 / OpenID Connect resource server standards compatible with any compliant identity provider.
- **Isolated Storage**: Dedicated PostgreSQL schema ensuring zero database dependencies on other CloudRader services.

---

## :material-folder-open-outline: Project Repositories

| Component | Repository | Description | Technology | Source |
| :--- | :--- | :--- | :--- | :--- |
| **API Backend** | `CloudRader/inventarium-api` | Kotlin / Spring Boot backend service, data models, Liquibase migrations | Kotlin / Spring Boot / PostgreSQL | [GitHub :fontawesome-brands-github:](https://github.com/CloudRader/inventarium-api) |

---

## :material-clock-outline: Current Status & Roadmap

!!! info "Active Backend Development"
    Inventarium is under active backend design and implementation in [`CloudRader/inventarium-api`](https://github.com/CloudRader/inventarium-api).

    - **Next Milestones**: Core asset models, check-in/out workflows, and REST API endpoints.
    - **Follow Progress**: Check out the [Ecosystem Roadmap](../../ecosystem/roadmap.md) for organization-wide milestones and release schedules.
