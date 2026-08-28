# CloudRader Documentation

<div align="center">
  <img src="docs/assets/logo.png" alt="CloudRader Logo" width="100" />
  <p><strong>Central documentation for the CloudRader organization and ecosystem.</strong></p>
</div>

---

This repository contains the organization-wide documentation for CloudRader and its projects. It is built using **Zensical**, a modern static site generator focused on simplicity and performance.

## 🚀 Local Development

We use [uv](https://github.com/astral-sh/uv) for fast Python package management.

### Prerequisites

1. **Install `uv`** (if you haven't already):
   ```bash
   curl -LsSf https://astral-sh.uv/install.sh | sh
   ```

### Running the Site

1. **Clone the repository**:
   ```bash
   git clone https://github.com/CloudRader/docs.git
   cd docs
   ```

2. **Install dependencies and start the server**:
   ```bash
   make install
   make serve
   ```
   The site will be available at `http://localhost:8000`.

## 🛠️ Project Structure

- `docs/`: Contains the Markdown source files for the documentation.
- `docs/assets/`: Images, logos, and custom CSS stylesheets.
- `zensical.toml`: Configuration for the Zensical site generator.

## 🌈 Contributing

We welcome contributions! Please feel free to open issues or submit pull requests to improve our organization documentation.

---

[Explore CloudRader](https://cloudrader.com)
