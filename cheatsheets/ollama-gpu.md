#  **GPU with Ollama**

## 🛠️ Step-by-Step GPU Activation for Ollama

### 1. ✅ Ensure You Have a Supported GPU

* Ollama supports **NVIDIA GPUs** with **CUDA 11.8 or later**.
* You must have:

  * NVIDIA driver installed
  * CUDA Toolkit 11.8+
  * cuDNN libraries (optional but improves performance)

To check:

```bash
nvidia-smi
```

### 2. ✅ Install Ollama with GPU Support

If you're using Docker:

```bash
docker run --gpus all -p 11434:11434 ollama/ollama
```

For **local installations (Linux/macOS)**:

* If `ollama` is installed via the standard `.pkg` or `.deb`, it should automatically detect GPU if:

  * You have a CUDA-capable GPU.
  * Your drivers and libraries are properly installed.

> ⚠️ Ollama **does not currently support GPU acceleration on Windows natively**, only via WSL2 with CUDA passthrough.

---

## 🔍 Verify GPU is Active

After launching a model, check logs:

```bash
ollama run llama3
```

In the console output, you should see lines like:

```
Using GPU: NVIDIA GeForce RTX 3080
```

Or run:

```bash
ollama run llama3 --verbose
```

If it's still using CPU, see troubleshooting below.

---

## 🧪 Test with GPU-Accelerated Backend (Optional)

Ollama uses **GGML/llama.cpp**, so it supports the `--use-gpu` toggle only in **compatible builds**.

If you're building from source:

```bash
OLLAMA_USE_CUBLAS=1 make
```

---

## ⚙️ Troubleshooting

| Issue                 | Fix                                                                                                                                           |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| Ollama still uses CPU | Ensure `nvidia-smi` detects GPU, and no other process is hogging memory.                                                                      |
| CUDA not found        | Install [CUDA 11.8](https://developer.nvidia.com/cuda-11-8-0-download-archive) and ensure `LD_LIBRARY_PATH` includes `/usr/local/cuda/lib64`. |
| GPU memory error      | Try a smaller model like `llama2:7b` or `phi3`.                                                                                               |

---

## 🧩 Optional: Use GPU in WSL2

If you're on **Windows** and want GPU support:

1. Install WSL2 with Ubuntu
2. Install NVIDIA WSL drivers: [link](https://developer.nvidia.com/cuda/wsl)
3. Install CUDA toolkit
4. Launch Ollama in WSL
