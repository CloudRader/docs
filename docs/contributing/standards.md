---
title: Development Standards
icon: lucide/file-code-2
---

# Development Standards :material-ruler-square-compass:{ .main-color }

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Python 3.12+</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M16 18l6-6-6-6M8 6l-6 6 6 6"/></svg> TypeScript Strict</span>
<span class="badge badge-purple"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="4 17 10 11 4 5"/><line x1="12" y1="19" x2="20" y2="19"/></svg> Ruff & Mypy</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="4"/><line x1="1.05" y1="12" x2="7" y2="12"/><line x1="17.01" y1="12" x2="22.96" y2="12"/></svg> Conventional Commits</span>

To keep the CloudRader ecosystem consistent, robust, and maintainable across all independent services, every repository adheres to these core engineering standards and development conventions.

---

## :material-table: Standards Overview Matrix

| Domain | Primary Technologies | Core Standards & Requirements |
| :--- | :--- | :--- |
| **Backend Services** | Python 3.12+, FastAPI, SQLAlchemy 2.0 | Async I/O, Pydantic v2 schemas, Alembic migrations, `uv` locking |
| **Frontend Applications** | TypeScript, React, Tailwind CSS | Strict type checking, responsive design, decoupled API clients |
| **Code Quality** | Ruff, Mypy, Pre-commit | Zero linter warnings, strict type hints across all function signatures |
| **Documentation** | Markdown, Zensical, Mermaid | One H1 per page, descriptive headings, ASCII prose, valid links |
| **Version Control** | Git, Conventional Commits | Scoped commit messages (`feat`, `fix`, `docs`), atomic pull requests |

---

## :material-language-python: Backend Standards (Python)

All Python services within CloudRader follow modern, asynchronous Python development standards:

### 1. Runtime & Package Management
- **Python Version**: Python 3.12+ (pinned per repository in `pyproject.toml`).
- **Package Manager**: Use [`uv`](https://github.com/astral-sh/uv) as the single tool for dependency resolution, virtual environment management, and lockfile maintenance (`uv.lock`).
- **Dependencies**: Group development and testing dependencies separately under `[dependency-groups]` in `pyproject.toml`.

### 2. Framework & Architecture
- **Framework**: [FastAPI](https://fastapi.tiangolo.com/) for declarative REST APIs with automatic OpenAPI 3.0 schema generation.
- **Layered Architecture**: Decouple domain models, database repositories, application services, and HTTP route handlers.
- **Data Validation**: [Pydantic v2](https://docs.pydantic.dev/) for data models, request parsing, and environment configuration (`pydantic-settings`).

### 3. Persistence & Database Migrations
- **ORM**: [SQLAlchemy 2.0](https://www.sqlalchemy.org/) using asynchronous sessions (`AsyncSession`) and drivers (`asyncpg` for PostgreSQL).
- **Migrations**: Database schema evolution must be managed via explicit, versioned [Alembic](https://alembic.sqlalchemy.org/) migration scripts.
- **Data Isolation**: Services manage their own independent database schemas; cross-database joins and shared tables are prohibited.

### 4. Code Quality & Type Safety
- **Linter & Formatter**: [Ruff](https://github.com/astral-sh/ruff) handles all linting and formatting in a single pass.
- **Type Checking**: Full static type hints are required on all function signatures, methods, and variables using `mypy`.

---

## :material-language-typescript: Frontend Standards (Web UI)

CloudRader user interfaces are designed to be fast, responsive, and accessible across mobile and desktop browsers:

### 1. Language & Typing
- **TypeScript**: Strict mode enabled (`"strict": true`). Avoid `any` types; define explicit interfaces and generic types in dedicated type definitions.
- **Build Tooling**: Vite with modern ECMAScript target modules for fast development and lightweight production bundles.

### 2. Component Architecture & State
- **React**: Functional components with hooks. Keep UI components focused on presentation.
- **Data Fetching**: Use TanStack Query (React Query) or typed Axios client modules for server state, background caching, and optimistic updates.
- **Separation of Concerns**: Never embed direct raw network calls inside rendering components.

### 3. Styling & Responsive Design
- **Tailwind CSS**: Utility-first CSS framework for clean, maintainable styling.
- **Mobile First**: All layouts must be responsive, adapting smoothly to mobile viewports (`< 768px`) with slide-over drawers, touch targets, and horizontal table scrolling.
- **Theme Support**: Design components to respect both light and dark color schemes cleanly.

---

## :material-file-document-outline: Documentation Standards

Documentation in CloudRader is treated as a first-class product artifact:

- **Engine**: Author documentation in Markdown rendered by [Zensical](https://github.com/zensical).
- **Structure**: Exactly one H1 (`#`) per page, followed by logical H2 (`##`) and H3 (`###`) hierarchy.
- **Icons & Badges**: Use Zensical icon shortcodes (`:material-...:`, `:fontawesome-...:`) and CSS badge classes. Do not use raw emoji in headings.
- **Fenced Blocks**: Always specify code language tags (`bash`, `python`, `typescript`, `yaml`, `mermaid`) for syntax highlighting.
- **Typography**: Use backticks for commands, filenames, paths, and literal values. Use ASCII for new text.
- **Relative Links**: Verify all cross-references and internal links resolve correctly.

---

## :material-source-commit: Commit Message Conventions

We adhere to the [Conventional Commits](https://www.conventionalcommits.org/) specification across all repositories:

```text
<type>(<scope>): <subject>

[optional body]

[optional footer(s)]
```

### Commit Types

| Type | Purpose | Example |
| :--- | :--- | :--- |
| `feat` | Introduces a new user-facing feature or capability | `feat(api): add QR code export endpoint for assets` |
| `fix` | Patches a bug or unintended behavior | `fix(auth): handle null response when user has no accesses` |
| `docs` | Documentation additions or revisions | `docs(hosting): add reverse proxy guide for Traefik` |
| `refactor` | Code restructuring without altering external behavior | `refactor(db): extract database session dependency into port` |
| `chore` | Maintenance tasks, dependency bumps, or tooling | `chore(deps): bump ruff from 0.15.4 to 0.15.5` |
| `ci` | Modifications to CI/CD workflows and automated scripts | `ci(build): add automated pre-commit validation workflow` |
| `test` | Adding or updating unit, integration, or regression tests | `test(user): add unit tests for OIDC group synchronization` |

!!! tip "Commit Message Guidelines"
    - Keep the subject line concise (under 72 characters) and written in the imperative mood (e.g., "add", "fix", not "added" or "fixing").
    - Include a scope in parentheses when the change targets a specific sub-package, module, or layer (e.g., `feat(backend):`, `fix(ui):`, `docs(overview):`).
    - Use the commit body to explain the context, rationale, and non-obvious design decisions behind the change.
