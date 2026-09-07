# CloudRader Documentation

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Modular</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> Self-hostable</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M18 10h-1.26A8 8 0 1 0 9 20h9a5 5 0 0 0 0-10z"></path></svg> Cloud-native</span>

Welcome to the central documentation portal for the **CloudRader** organization. This site serves as the unified knowledge base, architectural overview, and guide repository for services and tools across the CloudRader ecosystem.

---

### :fontawesome-solid-map: Explore the Documentation

Choose a section below to dive into specific details:

<div class="grid cards" markdown>

-   :fontawesome-solid-compass:{ .main-color } __[Overview]__

    ---

    Introduction to the CloudRader initiative, mission, and philosophy.

-   :fontawesome-solid-layer-group:{ .main-color } __[Ecosystem]__

    ---

    Architectural principles, system layers, and multi-service roadmap.

-   :fontawesome-solid-cubes:{ .main-color } __[Projects]__

    ---

    Independent services including Reservium (reservations) and Inventarium (assets).

-   :fontawesome-solid-server:{ .main-color } __[Self-Hosting]__

    ---

    Unified Docker Compose stack, Keycloak SSO, and reverse proxy setup.

-   :fontawesome-solid-handshake:{ .main-color } __[Contributing]__

    ---

    Development standards, code conventions, and contribution workflow.

</div>

  [Overview]: overview/about.md
  [Ecosystem]: ecosystem/index.md
  [Projects]: projects/index.md
  [Self-Hosting]: hosting/quickstart-stack.md
  [Contributing]: contributing/index.md

---

## :fontawesome-solid-circle-question: Getting Started

If you are new to CloudRader, we recommend starting with **[What is CloudRader?](overview/about.md)** to understand our modular architecture and philosophy.

### Why a modular ecosystem?

CloudRader applications are built to operate independently while integrating seamlessly:

!!! info "Modular & Self-Hostable"
    - **Independent Services**: Run only the tools you need (like Reservium for reservations) without monolithic bloat.
    - **Unified Experience**: Connect services through shared OpenID Connect (Keycloak) authentication for effortless single sign-on.

    Learn more about our architecture in the [Ecosystem Architecture](ecosystem/architecture.md) guide.
