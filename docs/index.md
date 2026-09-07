# Welcome to CloudRader! :fontawesome-solid-cloud:{ .main-color }

## What is CloudRader?

Welcome to the **CloudRader Documentation**. This documentation is designed to help you navigate and understand the CloudRader ecosystem of modular, self-hostable tools. Whether you're an administrator, developer, or homelab enthusiast, you'll find everything you need here.

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
