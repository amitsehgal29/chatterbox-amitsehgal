# RunPod Deployment Troubleshooting

## 🚨 **Quick Fix for Package Installation Errors**

If you're getting 403 Forbidden errors during `apt-get install`, use this **improved command**:

### **✅ Robust Docker Command (handles package failures gracefully):**

```bash
bash -c "
export DEBIAN_FRONTEND=noninteractive && 
apt-get update -qq && 
apt-get install -y --no-install-recommends git libsndfile1 wget curl && 
apt-get install -y --no-install-recommends ffmpeg || echo 'FFmpeg install failed, continuing without it...' && 
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

## 🔧 **What This Fixed:**

1. **✅ Git authentication**: Uses public repository access
2. **✅ Package failures**: Continues even if FFmpeg install fails  
3. **✅ Repository exists**: Checks if already cloned before cloning
4. **✅ Environment**: Sets proper DEBIAN_FRONTEND to avoid prompts
5. **✅ Essential packages**: Prioritizes git and libsndfile1 over ffmpeg

## 🎯 **Alternative: Minimal Installation**

If you're still having package issues, try this minimal approach:

```bash
bash -c "
cd /workspace && 
git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git && 
cd chatterbox-amitsehgal && 
pip install --no-cache-dir -r requirements.txt && 
python3 server.py
"
```

## 📋 **Common Issues & Solutions:**

### Issue: "403 Forbidden" on package download
- **Cause**: Ubuntu mirror restrictions or temporary issues
- **Solution**: Use the improved command above that handles failures gracefully

### Issue: "fatal: could not read Username for 'https://github.com'"
- **Cause**: Repository privacy settings or authentication
- **Solution**: Ensure repository is **public** on GitHub

### Issue: FFmpeg missing warnings
- **Impact**: Some audio processing features may be limited
- **Solution**: TTS will still work, just without some advanced audio features

### Issue: Model download taking too long
- **Cause**: First-time model download from Hugging Face
- **Solution**: Be patient, models are cached after first download

## 🌐 **Access Your Deployment:**

Once running successfully, access at:
- **Web UI**: `https://[your-pod-id]-8004.proxy.runpod.net`
- **API Docs**: `https://[your-pod-id]-8004.proxy.runpod.net/docs`

## 💡 **Pro Tips:**

1. **Use Container Logs** in RunPod to monitor setup progress
2. **Wait 5-10 minutes** for first startup (dependency + model download)
3. **Restart Pod** if setup fails - sometimes mirror issues resolve
4. **Check Repository** is public and accessible at: https://github.com/amitsehgal29/chatterbox-amitsehgal
