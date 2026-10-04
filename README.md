# CloudRader Documentation

<div align="center">
  <img src="docs/assets/logo.png" alt="CloudRader Logo" width="100" />
  <p><strong>Central documentation for the CloudRader organization and ecosystem.</strong></p>
</div>

---

This repository contains the organization-wide documentation for CloudRader and its projects. It is built using **Zensical**, a modern static site generator focused on simplicity and performance.

## 🚀 Local Development

We use [mise](https://mise.jdx.dev) to automatically manage the pinned development environment (Python, uv, and pre-commit) and execute project tasks.

### Prerequisites

- [mise](https://mise.jdx.dev)
- [git](https://git-scm.com/)

### Running the Site

1. **Clone the repository**:
   ```bash
   git clone https://github.com/CloudRader/docs.git
   cd docs
   ```

2. **Install tools, dependencies, and start the preview server**:
   ```bash
   mise install
   mise run install
   mise run serve
   ```
   The site will be available at `http://localhost:8000`.

## 🛠️ Project Structure

- `docs/`: Contains the Markdown source files for the documentation.
- `docs/assets/`: Images, logos, and custom CSS stylesheets.
- `mise.toml`: Pinned tool versions and task runner configuration.
- `zensical.toml`: Configuration for the Zensical site generator.

## 🌈 Contributing

We welcome contributions! Please feel free to open issues or submit pull requests to improve our organization documentation.

---

[Explore CloudRader](https://cloudrader.com)
