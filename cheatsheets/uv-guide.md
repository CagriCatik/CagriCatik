# UV

UV is a **modern, high-performance Python package and project manager** developed by **Astral**, the creators of **Ruff**.  
Written in **Rust**, UV unifies and accelerates the Python development workflow by replacing multiple tools such as  
`pip`, `virtualenv`, `pip-tools`, `pipx`, and `pyenv` into a **single cohesive interface**.

> The abbreviation **"uv"** is commonly interpreted as **"Universal Virtualenv"**, representing its goal to unify environment management, dependency handling, and Python version control.

---

## ⚡ Overview

UV provides an integrated system for:

- **Dependency management**
- **Virtual environment handling**
- **Python version control**
- **CLI tool management**
- **Script execution**

It delivers **Rust-level speed** with the familiarity of Python tooling.

---

## 🚀 Key Features

### 1. Blazing Fast Performance

- Up to **10–100x faster** than traditional tools like `pip`.
- Utilizes **global caching** to reuse dependencies across projects.
- Designed for **deterministic**, reproducible installs using `uv.lock`.

### 2. Integrated Environment Management

- Automatically manages virtual environments; no need for `venv` or `virtualenv`.
- Uses `pyproject.toml` and `uv.lock` to maintain reproducible builds.

### 3. Unified Tooling

UV consolidates multiple tools into one interface:

| Function | Replaces | Example Command |
|-----------|-----------|-----------------|
| Package management | `pip`, `pip-tools` | `uv add requests` |
| Virtual envs | `virtualenv` | `uv init`, `uv run` |
| Python versioning | `pyenv` | `uv python install 3.12` |
| CLI tool management | `pipx` | `uv tool install ruff` |

### 4. Python Version Management

- Install and manage multiple interpreters (`uv python install`).
- Pin Python versions per project (`uv python pin 3.12`).
- Works with unmanaged system Python installations seamlessly.

### 5. Cross-Platform

Supports **macOS**, **Linux**, and **Windows** with consistent commands.

---

## 🔧 Installation

### macOS & Linux

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
````

### Windows (PowerShell)

```powershell
irm https://astral.sh/uv/install.ps1 | iex
```

### Python Package Managers

```bash
pip install uv
# or
pipx install uv
```

Verify:

```bash
uv --version
```

---

## 🧱 Project Initialization

Create a new project:

```bash
uv init my_project
```

Creates:

```
.git/
.gitignore
.python-version
pyproject.toml
uv.lock
main.py
```

Options:

```bash
uv init --app --package    # Application project
uv init --lib --package    # Library project
uv init --python 3.12      # Use Python 3.12
```

---

## 📦 Dependency Management

### Add or Remove Dependencies

```bash
uv add requests flask
uv remove flask
```

### Add Dev or Custom Groups

```bash
uv add --dev pytest
uv add --group lint ruff
```

### Synchronize & Inspect

```bash
uv sync               # Sync dependencies with lockfile
uv tree               # Display dependency tree
uv lock --upgrade     # Upgrade locked dependencies
uv add -r requirements.txt  # Import from legacy pip requirements
```

---

## 🧩 Running Scripts

Run scripts with isolated environments:

```bash
uv run main.py
```

If the environment doesn’t exist, UV automatically recreates it.
You can also inline dependencies:

```python
# main.py
# uv: requests

import requests
print(requests.get('https://api.example.com').status_code)
```

Run directly:

```bash
uv run main.py
```

---

## ⚙️ Tool Management

Install, list, and manage Python CLI tools:

```bash
uv tool install ruff
uv tool list
uv tool upgrade --all
```

Run directly:

```bash
uvx ruff check .
```

Install editable or dependency-extended tools:

```bash
uv tool install -e        # Install current dir as editable tool
uv tool install --with dep
```

---

## 🐍 Python Version Management

### Install & Manage Interpreters

```bash
uv python install 3.13
uv python list
uv python upgrade
```

### Pin Python per Project

```bash
uv python pin 3.12
```

### Run with a Specific Version

```bash
uv run --python 3.12 python
```

---

## 🔄 Project Lifecycle

Check version and bump releases:

```bash
uv version
uv bump major     # 1.2.3 → 2.0.0
uv bump minor     # 1.2.3 → 1.3.0
uv bump alpha     # Mark pre-release
uv bump stable    # Mark final release
```

Build and publish:

```bash
uv build
uv publish
```

---

## 🧪 Migrating Existing Projects

1. Initialize UV:

   ```bash
   uv init
   ```

2. Import dependencies:

   ```bash
   uv add -r requirements.txt
   ```

3. Remove `requirements.txt` (use `pyproject.toml` + `uv.lock`).

---

## 🧾 Meta Commands

```bash
uv help python pin   # Subcommand help
uv self version      # Check uv version
uv self update       # Update uv CLI
```

---

## ✨ Formatting and Utilities

Format code with Ruff:

```bash
uv format
```

---

## 🧓 Legacy Compatibility

```bash
uv venv path/to/.venv --python 3.12
uv pip install requests
```

Brings `pip`/`venv` workflows under UV’s faster, managed interface.

---

## 🧠 Best Practices

- Always **commit** `uv.lock` for reproducible builds.
- Use `uv python pin` to ensure consistent interpreter across team & CI.
- Prefer `uv tool install` or `uvx` for CLI utilities to keep environments clean.
- Benchmark installs (`uv` is significantly faster with warm cache).

---

## 📚 Resources

- **Docs:** [https://docs.astral.sh/uv](https://docs.astral.sh/uv)
- **GitHub:** [https://github.com/astral-sh/uv](https://github.com/astral-sh/uv)
- **Real Python Guide:** [https://realpython.com/python-uv/](https://realpython.com/python-uv/)
- **Cheatsheet:** [https://mathspp.com/blog/uv-cheatsheet](https://mathspp.com/blog/uv-cheatsheet)
- **More Cheatsheets:** [https://mathspp.com/cheatsheets](https://mathspp.com/cheatsheets)
