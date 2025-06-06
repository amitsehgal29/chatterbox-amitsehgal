# RunPod Template Configuration for Chatterbox TTS Server

## 🚀 Recommended RunPod Deployment

### **Quick Deploy Command (Recommended)**

Use this optimized command in RunPod's "Docker Command" field for fastest deployment:

```bash
bash -c "export DEBIAN_FRONTEND=noninteractive && apt-get update -qq && apt-get install -y --no-install-recommends git libsndfile1 wget curl && apt-get install -y --no-install-recommends ffmpeg || echo 'FFmpeg install failed, continuing...' && cd /workspace && if [ ! -d 'chatterbox-amitsehgal' ]; then git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git; fi && cd chatterbox-amitsehgal && pip install --no-cache-dir -r requirements.txt && echo 'Starting Chatterbox TTS Server on port 8004...' && python3 server.py"
```

**Template Configuration:**
- **Container Image:** `runpod/pytorch:2.1.0-py3.10-cuda12.1.1-devel-ubuntu22.04`
- **Container Disk:** 20GB minimum
- **Expose HTTP Ports:** `8004`
- **Environment Variables:**
  ```
  PYTHONDONTWRITEBYTECODE=1
  PYTHONUNBUFFERED=1
  HF_HUB_ENABLE_HF_TRANSFER=1
  NVIDIA_VISIBLE_DEVICES=all
  NVIDIA_DRIVER_CAPABILITIES=compute,utility
  ```

## 🚀 Alternative RunPod Deployment Methods

Since uploading large Docker images can be challenging, here are additional approaches:

### **Method 1: Use Pre-built PyTorch Container + Startup Script**

1. **Go to RunPod.io** → **Templates** → **Create Template**

2. **Container Configuration:**
   ```
   Container Image: runpod/pytorch:2.1.0-py3.10-cuda12.1.1-devel-ubuntu22.04
   Container Disk: 20GB minimum
   Expose HTTP Ports: 8004
   Expose TCP Ports: (leave empty)
   ```

3. **Environment Variables:**
   ```
   PYTHONDONTWRITEBYTECODE=1
   PYTHONUNBUFFERED=1
   HF_HUB_ENABLE_HF_TRANSFER=1
   NVIDIA_VISIBLE_DEVICES=all
   NVIDIA_DRIVER_CAPABILITIES=compute,utility
   ```

4. **Docker Command:**
   ```bash
   bash -c "
   export DEBIAN_FRONTEND=noninteractive && 
   apt-get update -qq && 
   apt-get install -y --no-install-recommends git libsndfile1 wget curl && 
   apt-get install -y --no-install-recommends ffmpeg || echo 'FFmpeg install failed, continuing...' && 
   cd /workspace && 
   if [ ! -d 'chatterbox-amitsehgal' ]; then 
     git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git; 
   fi && 
   cd chatterbox-amitsehgal && 
   pip install --no-cache-dir -r requirements.txt && 
   echo 'Starting Chatterbox TTS Server on port 8004...' && 
   python3 server.py
   "
   ```

### **Method 2: Use Jupyter Notebook Approach**

1. **Container Image:** `runpod/pytorch:2.1.0-py3.10-cuda12.1.1-devel-ubuntu22.04`
2. **Start Jupyter Lab** and run setup manually
3. **Open Terminal** in Jupyter and run:
   ```bash
   cd /workspace
   git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git
   cd chatterbox-amitsehgal
   pip install -r requirements.txt
   python3 server.py
   ```

### **Method 3: Pre-configured Docker Command**

Use this single command in RunPod's "Docker Command" field:

```bash
bash -c "
echo '🚀 Setting up Chatterbox TTS Server...' && 
export DEBIAN_FRONTEND=noninteractive && 
apt-get update -qq && 
apt-get install -y --no-install-recommends git libsndfile1 wget curl && 
apt-get install -y --no-install-recommends ffmpeg || echo 'FFmpeg install failed, continuing...' && 
cd /workspace && 
if [ ! -d 'chatterbox-amitsehgal' ]; then 
  git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git; 
fi && 
cd chatterbox-amitsehgal && 
echo '📦 Installing dependencies...' && 
pip install --no-cache-dir -r requirements.txt && 
echo '🎵 Starting server on port 8004...' && 
python3 server.py
"
```

## ✅ **Advantages of This Approach:**

- ✅ **No large upload required** - uses RunPod's fast base images
- ✅ **Always up-to-date** - pulls latest code from GitHub
- ✅ **Faster deployment** - RunPod's images are cached
- ✅ **Smaller footprint** - only downloads what's needed
- ✅ **Easy updates** - just push to GitHub and restart

## 🔧 **GPU Configuration:**

- **Recommended GPU:** RTX 4090 or A6000
- **Memory:** 24GB+ VRAM for best performance
- **Storage:** 20GB+ (for model cache)

## 🌐 **Access:**

Once deployed, access your Chatterbox TTS Server at:
- **Web UI:** `https://[your-runpod-id]-8004.proxy.runpod.net`
- **API Docs:** `https://[your-runpod-id]-8004.proxy.runpod.net/docs`

## 📝 **Notes:**

- First startup takes 5-10 minutes (dependency installation + model download)
- Models are cached after first run for faster subsequent starts
- RunPod automatically handles HTTPS proxy and domain routing
