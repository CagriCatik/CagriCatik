# 🧠 Local Assistant – VS Code with Continue + Ollama

**Local Assistant** is a fully local AI development companion powered by [Continue](https://continue.dev/), [Ollama](https://ollama.com/), and open-source LLMs. It brings fast, private, and powerful language models like **LLaMA 3**, **Qwen2.5-Coder**, and **Nomic-Embed** right into your VS Code editor for chat, code editing, embedding, and autocomplete.

---

## 📦 Features

- ✨ **Fully local** LLM execution (no API keys or internet required)
- 💬 Chat with models like LLaMA 3.1 locally inside VS Code
- ✍️ Inline code editing with AI assistance
- ⚡ Autocomplete via Qwen2.5-Coder
- 📚 Embedding-based context awareness with Nomic-Embed
- 🔐 100% private — no data ever leaves your machine

---

## 🔧 Requirements

- [VS Code](https://code.visualstudio.com/)
- [Continue Extension](https://marketplace.visualstudio.com/items?itemName=Continue.continue)
- [Ollama](https://ollama.com/) (local LLM runtime)
- Compatible OS (macOS, Linux, Windows with WSL)

---

## 🚀 Installation Steps

### 1. Install Ollama

Download and install Ollama from:  
👉 [https://ollama.com/download](https://ollama.com/download)

Ensure it's running:
```bash
ollama serve
````

Then pull the required models:

```bash
ollama pull llama3.1:8b
ollama pull qwen2.5-coder:1.5b-base
ollama pull nomic-embed-text
```

---

### 2. Install Continue Extension

1. Open VS Code.
2. Go to Extensions (`Ctrl+Shift+X`)
3. Search for **Continue**
4. Install the one by *Continue*

Or install via CLI:

```bash
code --install-extension Continue.continue
```

---

### 3. Configure Continue

Press `Ctrl+Shift+P` → type and select:

```
Continue: Open Config File
```

Replace the contents with the following:

```yaml
name: Local Assistant
version: 1.0.0
schema: v1

defaultModel: Llama 3.1 8B

models:
  - name: Llama 3.1 8B
    provider: ollama
    model: llama3.1:8b
    roles:
      - chat
      - edit
      - apply

  - name: Qwen2.5-Coder 1.5B
    provider: ollama
    model: qwen2.5-coder:1.5b-base
    roles:
      - autocomplete

  - name: Nomic Embed
    provider: ollama
    model: nomic-embed-text:latest
    roles:
      - embed

context:
  - provider: code
  - provider: docs
  - provider: diff
  - provider: terminal
  - provider: problems
  - provider: folder
  - provider: codebase
```

Save and reload the window (`Ctrl+Shift+P` → "Reload Window").

---

## 💡 Usage Guide

* 🗨️ **Chat**: Open the Continue sidebar and chat with the assistant.
* ✍️ **Edit Code**: Select code → Right-click → `Ask Continue`
* ⚡ **Autocomplete**: Begin typing, and Continue will complete code contextually using Qwen.
* 🔍 **Context awareness**: Based on open files, folders, and recent changes, embeddings help the model understand your code better.

---

## 🧩 Optional Enhancements

* Add more Ollama-supported models (e.g. `mistral`, `phi3`, `codellama`).
* Use Ollama with custom models: fine-tune or import GGUF/GGML files.
* Enable multi-turn context memory with file-based history.
* Integrate with Git for smarter commit message generation and diff explanation.

---

## 🧰 Troubleshooting

| Problem                      | Solution                                                                   |
| ---------------------------- | -------------------------------------------------------------------------- |
| Model not found              | Make sure it's pulled via `ollama pull model-name`                         |
| Ollama not responding        | Run `ollama serve` and verify port 11434 is active                         |
| Model too slow or heavy      | Try smaller variants (e.g., `llama3:8b-instruct`)                          |
| VS Code not detecting models | Reload window and recheck `continue.config.yaml` or `continue.config.json` |
| Embedding doesn't work       | Ensure `nomic-embed-text` is running and compatible with Continue version  |
