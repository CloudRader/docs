# AGENTS.md

## Project Overview

This repository contains the central documentation site for the CloudRader
organization and ecosystem. It is a single-package Python project that uses
Zensical to generate a static site from Markdown.

Key paths:

- `docs/`: Markdown pages and static assets.
- `docs/assets/`: Shared logo, images, and custom CSS.
- `zensical.toml`: Site navigation, theme, and Markdown extensions.
- `Makefile`: Local installation, development, build, and validation commands.
- `site/`: Generated site output; do not edit it by hand.
- `.github/workflows/build.yml`: GitHub Pages build and deployment workflow.

## Setup

Prerequisites:

- `uv`.
- Python `3.14.7`, as pinned by `pyproject.toml`.

Install the locked dependencies from the repository root:

```bash
make install
```

`pre-commit` is required for the validation target but is not listed as a
project dependency. Install it separately if needed, then install its Git hook:

```bash
make pre-commit-install
```

Do not commit `.venv`, `.cache`, or generated site files.

## Development Workflow

Build the documentation site locally:

```bash
make build
```

The generated files are written to `site/`. Preview the site with:

```bash
make serve
```

The default local URL is `http://localhost:8000`.

Edit Markdown under `docs/` and update the `nav` structure in `zensical.toml`
when adding, moving, or renaming pages. Keep shared images and stylesheets in
`docs/assets/`.

Use `make help` to list all available Makefile targets. Use `uv run ...`
directly only when a command has no Makefile target.

## Testing and Checks

There is no application test suite in this repository. Before submitting
documentation changes, run:

```bash
make check
```

This performs a clean Zensical build and runs all configured pre-commit hooks.
The hooks check trailing whitespace, final newlines, YAML, TOML, and unusually
large added files.

For focused validation, run:

```bash
make build
make pre-commit
```

## Code and Content Conventions

- Use Markdown for documentation and match the existing page structure and tone.
- Use the Zensical extensions already configured in `zensical.toml`, including
  admonitions, fenced code blocks, attributes, and grid cards.
- Keep navigation paths in `zensical.toml` synchronized with files under `docs/`.
- Use `-` for unordered list markers and `1.` for ordered list markers.
- Use backticks for commands, filenames, paths, and literal values.
- Use ASCII for new source text unless the content requires another character set.
- Keep site-wide styling in `docs/assets/stylesheets/extra.css`; do not add
  duplicate global CSS in individual pages.

## Documentation Pages

For adding or updating pages, use the repository-local skill
[`create-update-pages`](.agents/skills/create-update-pages/SKILL.md). It is the
source of truth for page structure, clarification questions, writing style,
links, screenshots, assets, and navigation changes. Read and follow it before
editing files under `docs/`; keep this guide focused on repository-wide
workflows and constraints.

## Build and Deployment

The production artifact is generated with:

```bash
make build
```

GitHub Actions deploys the generated `site/` directory to GitHub Pages on every
push to `main`. The workflow installs dependencies with `uv`, builds the site,
uploads the artifact, and deploys it. There is no separate pull-request
workflow in this repository, so run `make check` locally before review.

To remove generated output and caches locally:

```bash
make clean
```

## Security and Repository Hygiene

- Do not commit credentials, tokens, private keys, or production `.env` files.
- Documentation examples must use placeholders for external-service secrets.
- Keep required site assets reasonably sized; the large-file pre-commit hook
  checks newly added files.

## Pull Requests

No repository-specific title or commit-message convention is defined in the
checked-in configuration. Keep changes focused, describe affected pages or
configuration, and report the validation performed. At minimum, run
`make check` before requesting review.
