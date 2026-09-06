---
name: create-update-pages
description: Create or update CloudRader organization documentation pages. Use this skill when adding, editing, moving, or reorganizing Markdown pages under docs/, including page content, navigation, links, images, and shared presentation details. Inspect the surrounding pages and Zensical configuration first, preserve the existing CloudRader style, and do not invent product behavior or assets.
---

# CloudRader Documentation Pages

Use this skill only for the CloudRader docs repository and its `docs/` tree. Keep
changes consistent with the existing documentation site and avoid
introducing conventions that are not already supported by Zensical.

## Clarify Before Editing

Classify the request as a new page, an edit, a move, a removal, or a navigation
change. Inspect the closest existing page and the matching `nav` entry in
`zensical.toml` before asking questions.

Ask only for facts needed to remove ambiguity:

- Target section and path under `docs/`.
- Intended audience and expected outcome.
- Authoritative source for product details, links, dates, or technical claims.
- Required links, code examples, screenshots, diagrams, or other assets.
- For edits, which statements are outdated and which existing links or assets
  must remain compatible.

Do not guess product behavior, feature status, URLs, version numbers, or visual
assets. Mark unknown facts for the user or request the authoritative source.
Use placeholders for secrets and environment-specific values.

## Repository Structure

- `docs/index.md`: CloudRader organization documentation home page.
- `docs/ecosystem/`: Architecture principles and organization roadmap.
- `docs/projects/`: Service catalog and project overviews (Reservium, Inventarium).
- `docs/hosting/`: Self-hosting guides, Keycloak SSO, reverse proxy, and backups.
- `docs/contributing/`: Contribution guidelines, development standards, and workflows.
- `docs/assets/logo.png`: Shared logo and favicon.
- `docs/assets/stylesheets/extra.css`: Shared site styling.
- `zensical.toml`: Navigation, theme, and Markdown extension configuration.

Put shared branding in `docs/assets/`. Put page-specific assets in a nearby
section asset directory when one exists; create one only when the page needs
multiple local assets. Use descriptive lowercase kebab-case filenames.

When adding or moving a page, update the corresponding `nav` entry in
`zensical.toml`. Confirm that every active navigation path exists under `docs/`
and that relative links resolve from the page containing them.

## House Style

Match the closest neighboring page rather than introducing a new layout.

- Use one H1 per page and keep headings concise and descriptive.
- Use direct, factual prose suited to a public project site.
- Use `-` for unordered lists and `1.` for ordered lists.
- Use backticks for commands, filenames, paths, and literal values.
- Use admonitions, fenced code blocks, attributes, and grid cards only as
  supported by the existing `zensical.toml` configuration.
- Reuse the existing badge, icon, and button patterns on index pages.
- Use Zensical bundled icon shortcodes for visual markers, such as
  `:material-cloud-outline:`. Prefer Material icons for general UI and section
  markers; use Font Awesome brand icons for brands such as GitHub.
- Do not use Unicode emoji in headings when a Zensical icon shortcode can
  express the same meaning. Do not add custom SVG icons for ordinary content.
- Keep shared styling in `extra.css`; do not duplicate global CSS in Markdown.
- Use ASCII for new source text unless the content clearly requires another
  character set.
- Preserve existing terminology, capitalization, links, and page organization
  when editing established content.

## Links, Screenshots, and Assets

Use links when they point to confirmed CloudRader projects, repositories, or
resources. Check that local Markdown links and referenced files exist before
finishing.

Use screenshots or diagrams only when they show a real state supplied by the
user or available in the repository. Do not fabricate UI, product behavior, or
screenshots. For each image:

1. Save it under the nearest relevant `assets/` directory.
2. Reference it with a relative Markdown path.
3. Add concise alt text describing the visible content.
4. Check that the file exists and is readable.

## Editing Workflow

1. Read the target page, nearby pages, relevant navigation, and referenced
   assets.
2. Resolve missing factual details before writing them.
3. State the short content outline and identify navigation or asset changes.
4. Edit the smallest appropriate set of files and preserve unrelated changes.
5. Check headings, links, image paths, code fences, admonitions, and navigation.
6. Build the site and run the repository checks before reporting completion.

Use the Makefile for normal workflows:

```bash
make install
make build
make serve
make pre-commit
make check
```

`make check` runs a clean Zensical build and all configured pre-commit hooks.
There is currently no separate link checker or application test suite.

## Completion Report

Summarize the changed pages, navigation entries, and assets. Mention any facts
that were intentionally left unresolved. Report the exact validation commands
run and whether they passed; do not claim the build passed if dependency or
network issues prevented it from running.
