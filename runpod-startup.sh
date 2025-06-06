#!/bin/bash

# RunPod Startup Script for Chatterbox TTS Server
# This script runs when the RunPod container starts

set -e

echo "🚀 Starting Chatterbox TTS Server on RunPod..."

# Update system and install dependencies
apt-get update && apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    libsndfile1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Clone the repository
cd /workspace
if [ ! -d "chatterbox-amitsehgal" ]; then
    echo "📥 Cloning Chatterbox repository..."
    git clone https://github.com/amitsehgal29/chatterbox-amitsehgal.git
fi

cd chatterbox-amitsehgal

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install --no-cache-dir -r requirements.txt

# Set environment variables for optimal performance
export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1
export HF_HUB_ENABLE_HF_TRANSFER=1

# Start the server
echo "🎵 Starting Chatterbox TTS Server..."
python3 server.py

# Keep container running
tail -f /dev/null
