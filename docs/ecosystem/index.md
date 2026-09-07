# The CloudRader Ecosystem :material-rocket-launch-outline:{ .main-color }

## What is the Ecosystem?

The CloudRader ecosystem connects independent, single-purpose services through open standards, shared identity, and standardized deployment patterns.

---

### :fontawesome-solid-map: Explore the Ecosystem

Choose a section below to dive into architecture and roadmaps:

<div class="grid cards" markdown>

-   :fontawesome-solid-sitemap:{ .main-color } __[Ecosystem Architecture]__

    ---

    Detailed breakdown of core principles, layered architecture, and data isolation.

-   :fontawesome-solid-map-location-dot:{ .main-color } __[Ecosystem Roadmap]__

    ---

    Current development milestones, near-term goals, and future vision.

-   :fontawesome-solid-boxes-stacked:{ .main-color } __[Projects Catalog]__

    ---

    Directory of all active and planned services in the CloudRader initiative.

</div>

  [Ecosystem Architecture]: architecture.md
  [Ecosystem Roadmap]: roadmap.md
  [Projects Catalog]: ../projects/index.md

---

## :material-layers-triple: Ecosystem Foundations

All services within the CloudRader ecosystem adhere to shared structural foundations:

!!! info "Foundation Highlights"
    - **Single Sign-On (SSO)**: Powered by standard OpenID Connect (OIDC) via Keycloak.
    - **Isolated Persistence**: Each application owns its dedicated database schema without cross-database locks.
    - **Declarative Deployment**: Managed via standard Docker Compose configurations.
