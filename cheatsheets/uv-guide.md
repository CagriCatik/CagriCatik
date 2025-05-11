# UV

UV is a modern, high-performance Python package and project manager developed by Astral, the creators of Ruff. Written in Rust, UV aims to unify and streamline Python development workflows by replacing multiple tools like `pip`, `virtualenv`, `pip-tools`, `pipx`, and `pyenv` with a single, cohesive interface. This guide provides a detailed overview of UV's features, installation methods, and usage. ```uv``` is a modern, high-performance Python package and project manager developed by Astral, the creators of the Ruff linter.

> While the official documentation does not explicitly define the abbreviation ```uv``` it is commonly interpreted as ```Universal Virtualenv```. This reflects uv's goal of providing a unified tool that handles virtual environments, package management, and more, simplifying the Python development process.

Written in Rust, uv is designed to be a faster and more integrated alternative to traditional Python tools like `pip`, `virtualenv`, `pip-tools`, and `pipx`. It aims to streamline the Python development workflow by consolidating multiple functionalities into a single tool.

## Key Features of uv

* **Blazing Fast Performance**: uv offers significantly faster package installation and dependency resolution compared to traditional tools, thanks to its Rust-based implementation.

* **Integrated Virtual Environment Management**: Automatically creates and manages virtual environments, eliminating the need for manual setup with tools like `virtualenv`.
* **Modern Dependency Management**: Utilizes `pyproject.toml` and `uv.lock` files for managing dependencies, ensuring reproducible and consistent environments across different systems.

* **Tool Management**: Can install and run Python-based command-line tools in isolated environments, similar to `pipx`, using commands like `uv tool install` and `uvx`.

* **Python Version Management**: Supports installing and managing multiple Python versions, allowing for seamless switching and pinning of Python versions per project.

* **Cross-Platform Support**: Compatible with macOS, Linux, and Windows, making it a versatile choice for developers across different operating systems.


## 🔧 Installation

UV offers several installation methods to accommodate different operating systems and preferences:

### Standalone Installer (Recommended)

* **macOS and Linux:**

  ```bash
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```



* **Windows (PowerShell):**

  ```powershell
  irm https://astral.sh/uv/install.ps1 | iex
  ```

### Using Python Package Managers

* **pip:**

  ```bash
  pip install uv
  ```

* **pipx:**

  ```bash
  pipx install uv
  ```



After installation, verify UV is correctly installed by running:

```bash
uv --version
```

---

## 🚀 Key Features

### 1. Unified Tooling

UV consolidates the functionalities of multiple Python tools:

* **Package Management:** Replaces `pip` and `pip-tools` for installing and resolving dependencies.
* **Virtual Environments:** Supersedes `virtualenv` by automatically creating and managing isolated environments.
* **Python Version Management:** Offers capabilities similar to `pyenv` for installing and managing different Python versions.
* **CLI Tool Management:** Acts as an alternative to `pipx` for installing and running Python-based command-line tools.([astral.sh][4])

### 2. Performance

UV is designed for speed:([GitHub][5])

* **Fast Installations:** UV can be 10–100 times faster than traditional tools like `pip`, especially when using a warm cache.
* **Global Caching:** Utilizes a global cache to avoid redundant downloads and installations across projects.([Astral Docs][6])

### 3. Project Initialization

UV simplifies project setup:([via-internet.de][7])

```bash
uv init my_project
```



This command creates a new project directory with the following structure:

* `.git/` and `.gitignore` for version control.
* `.python-version` specifying the Python version.
* `pyproject.toml` for project configuration and dependencies.
* `uv.lock` for locking exact dependency versions.
* `main.py` as a starter script.

### 4. Dependency Management

* **Adding Packages:**

  ```bash
  uv add flask requests
  ```

* **Removing Packages:**

  ```bash
  uv remove flask
  ```

* **Synchronizing Dependencies:**

  ```bash
  uv sync
  ```

* **Viewing Dependency Tree:**

  ```bash
  uv tree
  ```

### 5. Running Scripts

UV allows you to run Python scripts without manually activating virtual environments:([Medium][11])

```bash
uv run main.py
```

If the virtual environment is missing, UV will automatically recreate it and install the necessary dependencies.

### 6. Tool Management

* **Installing CLI Tools:**

  ```bash
  uv tool install ruff
  ```

* **Running Tools Temporarily:**

  ```bash
  uv tool run ruff check
  ```

* **Using Shortcut (`uvx`):**

  ```bash
  uvx ruff check
  ```

* **Listing Installed Tools:**

  ```bash
  uv tool list
  ```

* **Upgrading Tools:**

  ```bash
  uv tool upgrade --all
  ```



### 7. Python Version Management

UV can install and manage different Python versions:

* **Installing Latest Python Version:**

  ```bash
  uv python install
  ```

* **Installing Specific Python Version:**

  ```bash
  uv python install 3.12
  ```

* **Listing Installed Python Versions:**

  ```bash
  uv python list
  ```
---

## 📁 Migrating Existing Projects

To transition an existing project to UV:

1. **Initialize UV in the Project Directory:**

   ```bash
   uv init
   ```

2. **Add Existing Dependencies:**

   ```bash
   uv add -r requirements.txt
   ```

3. **Remove `requirements.txt`:** After migration, you can rely on `pyproject.toml` and `uv.lock` for dependency management.

---

## 📄 Managing Dependency Groups

UV supports organizing dependencies into groups, such as development or testing:

* **Adding Development Dependencies:**

  ```bash
  uv add --dev pytest
  ```

* **Adding Custom Group Dependencies:**

  ```bash
  uv add --group lint ruff
  ```

These groups are reflected in the `pyproject.toml` under `[tool.uv.dependency-groups]`.

---

## 🧪 Using UV with Single-File Scripts

UV can execute standalone Python scripts with inline dependency metadata:([astral.sh][13])

```python
# main.py
# uv: requests

import requests

response = requests.get('https://api.example.com')
print(response.json())
```

Run the script using:

```bash
uv run main.py
```

UV will automatically install the specified dependencies and execute the script.

---

## 📚 Additional Resources

* **Official Documentation:** [docs.astral.sh/uv](https://docs.astral.sh/uv/)
* **GitHub Repository:** [github.com/astral-sh/uv](https://github.com/astral-sh/uv)
* **Real Python Guide:** [Managing Python Projects With uv](https://realpython.com/python-uv/)
