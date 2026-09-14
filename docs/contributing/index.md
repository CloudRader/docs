---
title: Contributing
icon: lucide/hand-heart
---

# Contributing to CloudRader :material-hand-heart-outline:{ .main-color }

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Open Source</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg> Community-Driven</span>
<span class="badge badge-purple"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"/><path d="m4.93 4.93 4.24 4.24"/><path d="m14.83 9.17 4.24-4.24"/><path d="m14.83 14.83 4.24 4.24"/><path d="m9.17 14.83-4.24 4.24"/></svg> Modular Standards</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg> Welcoming Culture</span>

Thank you for your interest in contributing to **CloudRader**! CloudRader is an open-source initiative built by and for communities, organizations, and teams who believe in self-hostable, modular infrastructure.

We welcome contributions of all forms: writing code, fixing bugs, authoring documentation, refining user interfaces, reporting issues, and suggesting architectural enhancements.

---

## :material-map: Explore the Contributing Guides

<div class="grid cards" markdown>

-   :material-ruler-square-compass:{ .main-color } __[Development Standards](standards.md)__

    ---

    Core technology standards, Python/FastAPI backend conventions, TypeScript frontend requirements, code formatting with Ruff, and commit message rules.

-   :material-source-branch:{ .main-color } __[Contribution Workflow](workflow.md)__

    ---

    Step-by-step contribution lifecycle: repository forking, branch naming, local development setup, pre-commit validation, and pull request submission.

</div>

---

## :material-hand-heart-outline: Ways to Contribute

You do not need to be an expert systems architect or core maintainer to get involved:

<div class="grid cards" markdown>

-   :material-code-braces:{ .main-color } __Code & Core Enhancements__

    ---

    Implement new features, optimize database queries, fix bugs, or expand REST API endpoints across our backend and frontend services.

-   :material-file-document-edit-outline:{ .main-color } __Documentation & Guides__

    ---

    Clarify existing guides, fix typographical errors, write self-hosting deployment recipes, or add troubleshooting walkthroughs.

-   :material-bug-outline:{ .main-color } __Issue Reporting & Triage__

    ---

    Test pre-releases, report reproducible bugs with log outputs, confirm edge cases, and provide feedback on planned roadmap features.

-   :material-palette-outline:{ .main-color } __Design & Accessibility__

    ---

    Improve user interface responsiveness on mobile web browsers, enhance color contrast, refine navigation flows, and polish iconography.

</div>

---

## :material-sitemap: Contribution Lifecycle

All contributions across CloudRader repositories follow a transparent, peer-reviewed workflow:

``` mermaid
flowchart LR
    Find["Find Issue<br/>or Propose Feature"] --> Branch["Fork & Create<br/>Feature Branch"]
    Branch --> Code["Develop & Format<br/>(Ruff / TypeScript)"]
    Code --> Check["Validate Locally<br/>(make check)"]
    Check --> PR["Submit Pull Request<br/>(Conventional Commits)"]
    PR --> Review["Automated CI<br/>& Maintainer Review"]
    Review --> Merge["Merged into<br/>main Branch"]
```

1. **Find or Propose**: Select an existing issue labeled `good first issue` or `help wanted`, or propose an enhancement via a GitHub issue.
2. **Fork & Branch**: Create an isolated, descriptive branch on your personal fork (`feat/my-feature` or `fix/issue-description`).
3. **Develop & Verify**: Write clean, typed code backed by tests and run local checks (`make check`) before pushing.
4. **Review & Merge**: Submit a pull request with a Conventional Commit title. Continuous integration validates the build, followed by maintainer review.

---

## :material-heart-outline: Community Code of Conduct

We are dedicated to providing a friendly, safe, and welcoming environment for everyone, regardless of experience level, background, or identity.

!!! info "Community Values"
    - **Be Respectful**: Treat all contributors and community members with kindness, empathy, and professional courtesy.
    - **Constructive Feedback**: Offer and receive critique constructively. Focus on the code, architecture, and documentation rather than individuals.
    - **Supportive Collaboration**: Welcome newcomers, answer questions patiently, and help one another build reliable open-source tooling.

---

## :fontawesome-brands-github: Project Repositories

Explore the core repositories in the CloudRader ecosystem:

| Repository | Description | Primary Languages | Source Code |
| :--- | :--- | :--- | :--- |
| **[CloudRader/docs](https://github.com/CloudRader/docs)** | Central organization documentation site | Markdown, Python, Zensical | [:fontawesome-brands-github: GitHub](https://github.com/CloudRader/docs) |
| **[CloudRader/reservium-api](https://github.com/CloudRader/reservium-api)** | Room and space reservation backend | Python, FastAPI, SQLAlchemy | [:fontawesome-brands-github: GitHub](https://github.com/CloudRader/reservium-api) |
| **[CloudRader/reservium-ui](https://github.com/CloudRader/reservium-ui)** | Web UI application for Reservium | TypeScript, React, Tailwind CSS | [:fontawesome-brands-github: GitHub](https://github.com/CloudRader/reservium-ui) |
| **[CloudRader/inventarium-api](https://github.com/CloudRader/inventarium-api)** | Asset and equipment tracking service | Kotlin, Spring Boot, PostgreSQL | [:fontawesome-brands-github: GitHub](https://github.com/CloudRader/inventarium-api) |
