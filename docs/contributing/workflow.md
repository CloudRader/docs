---
title: Contribution Workflow
icon: lucide/git-pull-request
---

# Contribution Workflow :material-source-branch:{ .main-color }

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> GitHub Fork & PR</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><line x1="6" y1="3" x2="6" y2="15"/><circle cx="18" cy="6" r="3"/><circle cx="6" cy="18" r="3"/><path d="M18 9a9 9 0 0 1-9 9"/></svg> Feature Branching</span>
<span class="badge badge-purple"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="20 6 9 17 4 12"/></svg> Pre-Commit Validation</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg> Automated CI</span>

This guide details the complete step-by-step process for contributing code, bug fixes, or documentation to any CloudRader project.

---

## :material-source-fork: Contribution Lifecycle

``` mermaid
flowchart TD
    Fork["1. Fork & Clone Repository"] --> Branch["2. Create Feature Branch<br/>(feat/..., fix/...)"]
    Branch --> Setup["3. Setup Environment<br/>(make install / uv sync)"]
    Setup --> Code["4. Implement & Format<br/>(Ruff / ESLint)"]
    Code --> Check["5. Validate Locally<br/>(make check)"]
    Check --> Commit["6. Commit Changes<br/>(Conventional Commits)"]
    Commit --> Push["7. Push & Open Pull Request"]
    Push --> CI["8. CI Checks & Code Review"]
    CI --> Merge["9. Merged into main!"]
```

---

## :material-numeric-1-box-outline: Step 1: Fork and Clone the Repository

1. Navigate to the target CloudRader repository on GitHub (e.g., [`CloudRader/docs`](https://github.com/CloudRader/docs)) and click **Fork**.
2. Clone your personal fork to your local workstation:

    ```bash
    git clone https://github.com/<your-username>/<repo-name>.git
    cd <repo-name>
    ```

3. Configure the upstream remote to keep your fork synchronized:

    ```bash
    git remote add upstream https://github.com/CloudRader/<repo-name>.git
    git fetch upstream
    ```

---

## :material-numeric-2-box-outline: Step 2: Create a Feature Branch

Always create a dedicated topic branch branched off the latest `upstream/main`:

```bash
git checkout main
git pull upstream main
git checkout -b <branch-name>
```

### Branch Naming Conventions

Use descriptive branch names prefixed by the change type:

| Branch Pattern | Purpose | Example |
| :--- | :--- | :--- |
| `feat/<name>` | New user-facing feature or capability | `feat/asset-qr-generation` |
| `fix/<name>` | Bug fix or error resolution | `fix/null-response-handling` |
| `docs/<name>` | Documentation updates or tutorials | `docs/refactor-contributing-guide` |
| `refactor/<name>` | Code refactoring without behavioral change | `refactor/service-database-layer` |
| `chore/<name>` | Tooling, dependencies, or repository hygiene | `chore/update-pre-commit-hooks` |

---

## :material-numeric-3-box-outline: Step 3: Local Environment Setup

CloudRader repositories use standard automation via `Makefile` and modern tooling:

1. **Install Dependencies**: Install locked dependencies using `make`:

    ```bash
    make install
    ```

    *(In Python repositories, this invokes `uv sync` under the hood).*

2. **Install Pre-Commit Hooks**: Ensure git hooks are active to catch formatting issues early:

    ```bash
    make pre-commit-install
    ```

---

## :material-numeric-4-box-outline: Step 4: Develop, Test & Format

1. Make focused, atomic changes following the [Development Standards](standards.md).
2. Preview documentation changes locally:

    ```bash
    make serve
    ```

    The local live preview runs at `http://localhost:8000`.

3. Run linters and formatting checks:

    ```bash
    make pre-commit
    ```

!!! tip "Fast Feedback"
    Pre-commit hooks automatically check trailing whitespace, final newlines, YAML/TOML validity, and file sizes. Running them before committing prevents failed CI runs.

---

## :material-numeric-5-box-outline: Step 5: Validate Locally with `make check`

Before committing or opening a pull request, run the full validation suite:

```bash
make check
```

This target performs:

- A clean, warnings-free build of the application or static site (`make build`).
- All configured pre-commit and linter checks (`make pre-commit`).

---

## :material-numeric-6-box-outline: Step 6: Commit and Push Changes

1. Stage your modified files:

    ```bash
    git add .
    ```

2. Author a concise commit message adhering to [Conventional Commits](standards.md#commit-message-conventions):

    ```bash
    git commit -m "docs(contributing): refactor guide with lifecycle diagrams and standards matrix"
    ```

3. Push the feature branch to your GitHub fork:

    ```bash
    git push -u origin <branch-name>
    ```

---

## :material-numeric-7-box-outline: Step 7: Open a Pull Request

1. Visit your fork on GitHub and click **Compare & pull request**.
2. Ensure the base repository is `CloudRader/<repo-name>` and the base branch is `main`.
3. Provide a clear summary:
    - **What**: Describe the changes made.
    - **Why**: Explain the problem solved or motivation.
    - **Verification**: Mention the tests and validation commands executed (`make check`).
    - **Issues**: Link relevant issues using GitHub keywords (e.g., `Closes #12`).
4. Wait for automated CI checks to complete and address any reviewer feedback.

---

## :material-bug-outline: Reporting Bugs & Requesting Features

If you encounter a problem or have an idea for an enhancement, please open an issue:

- **Bug Reports**: Include your environment details (OS, container engine, browser), exact steps to reproduce, expected versus actual behavior, and relevant error logs.
- **Feature Requests**: Describe the specific use case, explain why existing functionality does not address it, and outline your proposed solution.
