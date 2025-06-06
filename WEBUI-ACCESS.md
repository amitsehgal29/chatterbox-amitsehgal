# How to Access Chatterbox WebUI on RunPod

## 🚨 **Git Clone Error Fix**

If you're getting this error in your RunPod:
```
fatal: could not read Username for 'https://github.com': No such device or address
```

## 🔧 **Fixed Docker Command (Use This):**

```bash
bash -c "
echo '🚀 Setting up Chatterbox TTS Server...' && 
apt-get update -qq && 
apt-get install -y --no-install-recommends git ffmpeg libsndfile1 && 
cd /workspace && 
git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git chatterbox && 
cd chatterbox && 
echo '📦 Installing dependencies...' && 
pip install --no-cache-dir -r requirements.txt && 
echo '🎵 Starting server on port 8004...' && 
python3 server.py
"
```

## 🎯 **Alternative: Direct Download Method**

If Git still fails, use this wget-based approach:

```bash
bash -c "
echo '🚀 Setting up Chatterbox TTS Server...' && 
apt-get update -qq && 
apt-get install -y --no-install-recommends wget unzip ffmpeg libsndfile1 && 
cd /workspace && 
wget -O chatterbox.zip https://github.com/amitsehgal29/chatterbox-amitsehgal/archive/refs/heads/main.zip && 
unzip chatterbox.zip && 
mv chatterbox-amitsehgal-main chatterbox && 
cd chatterbox && 
echo '📦 Installing dependencies...' && 
pip install --no-cache-dir -r requirements.txt && 
echo '🎵 Starting server on port 8004...' && 
python3 server.py
"
```

## 🚨 **Important: Serverless vs Regular Pods**

**RunPod Serverless Endpoints:**
- ❌ **No WebUI access** - API calls only
- ✅ **Cost-effective** - pay per request
- ✅ **Auto-scaling** - handles traffic spikes
- 🔗 **Access method**: REST API calls only

**RunPod Regular Pods:**
- ✅ **Full WebUI access** - browse at `https://pod-id-8004.proxy.runpod.net`
- ✅ **Direct HTTP ports** - port 8004 exposed
- ✅ **Interactive use** - full web interface
- 💰 **Cost**: Hourly billing while running

## 🌐 **To Access WebUI: Use Regular Pod**

### **Step 1: Create Regular Pod Template**

1. Go to **RunPod.io** → **Templates** → **Create Template**
2. **Template Type**: Choose **"Pod"** (not Serverless)
3. **Configuration**:
   ```
   Container Image: runpod/pytorch:2.1.0-py3.10-cuda12.1.1-devel-ubuntu22.04
   Container Disk: 20GB
   Expose HTTP Ports: 8004
   ```

4. **Docker Command**:
   ```bash
   bash -c "apt-get update -qq && apt-get install -y git ffmpeg libsndfile1 && cd /workspace && git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git && cd chatterbox-amitsehgal && pip install -r requirements.txt && python3 server.py"
   ```

### **Step 2: Deploy Regular Pod**

1. **Deploy Pod** using your template
2. **Wait 5-10 minutes** for setup to complete
3. **Access WebUI** at: `https://[your-pod-id]-8004.proxy.runpod.net`

## 🔧 **Option 2: Use Serverless + Local Tunnel (Advanced)**

If you want to keep serverless, you can create a local tunnel:

### **A. Modify server.py for serverless**

Add this to your serverless deployment:

```python
# Add to server.py for serverless compatibility
import os
import requests
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

# Create tunnel endpoint for WebUI access
@app.get("/create-tunnel")
async def create_tunnel():
    """Create a temporary tunnel to access WebUI"""
    # This would require additional tunnel setup
    pass
```

### **B. Use ngrok or similar service**

Add to your Docker command:
```bash
# Install ngrok and create tunnel
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null &&
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list &&
sudo apt update && sudo apt install ngrok &&
ngrok http 8004 &
```

## 📱 **Option 3: Create Web Client Interface**

Create a simple web client that calls your serverless API:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Chatterbox TTS Client</title>
</head>
<body>
    <h1>Chatterbox TTS</h1>
    <textarea id="text" placeholder="Enter text to convert to speech"></textarea>
    <select id="voice">
        <option value="Emily.wav">Emily</option>
        <option value="Alexander.wav">Alexander</option>
        <!-- Add more voices -->
    </select>
    <button onclick="generateSpeech()">Generate Speech</button>
    <audio id="result" controls></audio>

    <script>
        async function generateSpeech() {
            const text = document.getElementById('text').value;
            const voice = document.getElementById('voice').value;
            
            const response = await fetch('YOUR_SERVERLESS_ENDPOINT', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({
                    input: {
                        text: text,
                        voice_id: voice
                    }
                })
            });
            
            const result = await response.json();
            document.getElementById('result').src = result.output.audio_url;
        }
    </script>
</body>
</html>
```

## 🎯 **Recommended Solution**

**For WebUI access, use Regular Pods:**

1. **Create Pod template** (not serverless)
2. **Deploy with HTTP port 8004 exposed**
3. **Access WebUI** at `https://pod-id-8004.proxy.runpod.net`
4. **Stop pod when not in use** to save costs

This gives you the full Chatterbox experience with the beautiful web interface!
