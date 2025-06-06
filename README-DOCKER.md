# Chatterbox TTS Server - Docker Deployment

This is a Docker-ready version of the Chatterbox TTS Server, optimized for deployment on RunPod and other cloud GPU platforms.

## 🚀 Quick Start

### Local Testing
```bash
# Run locally (CPU mode)
docker run -d --name chatterbox-local -p 8004:8004 amitsehgaldocker/chatterbox-tts-server:latest

# Access the web interface
open http://localhost:8004
```

### RunPod Deployment

#### **Quick Deploy (Recommended)**
Use this optimized command in RunPod's "Docker Command" field:

```bash
bash -c "export DEBIAN_FRONTEND=noninteractive && apt-get update -qq && apt-get install -y --no-install-recommends git libsndfile1 wget curl && apt-get install -y --no-install-recommends ffmpeg || echo 'FFmpeg install failed, continuing...' && cd /workspace && if [ ! -d 'chatterbox-amitsehgal' ]; then git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git; fi && cd chatterbox-amitsehgal && pip install --no-cache-dir -r requirements.txt && echo 'Starting Chatterbox TTS Server on port 8004...' && python3 server.py"
```

#### **Template Configuration**
1. **Create Template on RunPod.io**
   - Container Image: `runpod/pytorch:2.1.0-py3.10-cuda12.1.1-devel-ubuntu22.04`
   - Container Disk: 20GB minimum
   - Expose HTTP Ports: `8004`
   - Environment Variables:
     ```
     PYTHONDONTWRITEBYTECODE=1
     PYTHONUNBUFFERED=1
     HF_HUB_ENABLE_HF_TRANSFER=1
     NVIDIA_VISIBLE_DEVICES=all
     NVIDIA_DRIVER_CAPABILITIES=compute,utility
     ```

2. **Deploy with GPU**
   - Recommended: RTX 4090 or better
   - Access via HTTP service on port 8004

## 🔧 Key Modifications

### Docker Optimizations
- **Multi-architecture PyTorch**: Supports both CPU and GPU environments
- **CPU device mapping**: Fixed CUDA tensor loading on CPU-only systems
- **ARM64 compatibility**: Removed problematic dependencies
- **Auto device detection**: Automatically detects available hardware

### Files Modified
- `Dockerfile`: Enhanced for CPU/GPU compatibility
- `engine.py`: Added CPU device mapping support
- `config.yaml`: Auto device detection
- `requirements.txt`: ARM64 compatibility fixes
- `deploy.sh`: Automated deployment script

## 📦 Building from Source

```bash
# Clone this repository
git clone https://github.com/amitsehgal/chatterbox-amitsehgal.git
cd chatterbox-amitsehgal

# Build Docker image
docker build -t chatterbox-tts-server .

# Run locally
docker run -d --name chatterbox -p 8004:8004 chatterbox-tts-server
```

## 🌐 Features

- **Voice Cloning**: Upload reference audio for custom voices
- **Multiple Voices**: 28+ predefined voices included
- **Web Interface**: Modern, responsive UI
- **REST API**: Full API access at `/docs`
- **GPU Acceleration**: Optimized for NVIDIA GPUs
- **CPU Fallback**: Works on CPU-only environments

## 📋 Requirements

### For GPU Deployment (RunPod)
- NVIDIA GPU (RTX 4090+ recommended)
- 20GB+ storage
- 8GB+ VRAM

### For CPU Testing (Local)
- 8GB+ RAM
- 10GB+ storage
- Docker Desktop

## 🔗 Links

- **Docker Hub**: `amitsehgaldocker/chatterbox-tts-server:latest`
- **RunPod**: [runpod.io](https://runpod.io)
- **Original Project**: [Chatterbox-TTS-Server](https://github.com/devnen/Chatterbox-TTS-Server)

## 📝 License

This project maintains the same license as the original Chatterbox TTS Server.
