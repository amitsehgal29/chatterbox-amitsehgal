#!/bin/bash

# Chatterbox TTS Server Deployment Script for RunPod
# This script builds, tags, and pushes the Docker image to Docker Hub

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Chatterbox TTS Server Deployment Script ===${NC}"

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo -e "${RED}Error: Docker is not running. Please start Docker Desktop and try again.${NC}"
    exit 1
fi

# Get Docker Hub username
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: $0 <docker-hub-username>${NC}"
    echo -e "${YELLOW}Example: $0 yourusername${NC}"
    exit 1
fi

DOCKER_HUB_USERNAME="$1"
IMAGE_NAME="chatterbox-tts-server"
FULL_IMAGE_NAME="${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest"

echo -e "${BLUE}Building Docker image...${NC}"
echo -e "${YELLOW}This may take 10-15 minutes depending on your internet connection${NC}"

# Build the Docker image
docker build -t ${IMAGE_NAME} .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Docker image built successfully!${NC}"
else
    echo -e "${RED}❌ Docker build failed!${NC}"
    exit 1
fi

# Tag the image
echo -e "${BLUE}Tagging image for Docker Hub...${NC}"
docker tag ${IMAGE_NAME} ${FULL_IMAGE_NAME}

# List images to confirm
echo -e "${BLUE}Available images:${NC}"
docker images | grep ${IMAGE_NAME}

echo -e "${GREEN}✅ Image tagged as: ${FULL_IMAGE_NAME}${NC}"

# Login to Docker Hub
echo -e "${BLUE}Logging into Docker Hub...${NC}"
echo -e "${YELLOW}Please enter your Docker Hub credentials when prompted${NC}"
docker login

# Push to Docker Hub
echo -e "${BLUE}Pushing image to Docker Hub...${NC}"
docker push ${FULL_IMAGE_NAME}

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Image pushed successfully to Docker Hub!${NC}"
    echo -e "${GREEN}Image available at: ${FULL_IMAGE_NAME}${NC}"
    echo ""
    echo -e "${BLUE}=== RunPod Deployment Instructions ===${NC}"
    echo -e "${YELLOW}1. Go to RunPod.io and log in${NC}"
    echo -e "${YELLOW}2. Navigate to Templates → Create Template${NC}"
    echo -e "${YELLOW}3. Use these settings:${NC}"
    echo -e "   • Container Image: ${FULL_IMAGE_NAME}"
    echo -e "   • Container Disk: 20GB minimum"
    echo -e "   • Expose HTTP Ports: 8004"
    echo -e "   • Environment Variables:"
    echo -e "     - PYTHONDONTWRITEBYTECODE=1"
    echo -e "     - PYTHONUNBUFFERED=1"
    echo -e "     - HF_HUB_ENABLE_HF_TRANSFER=1"
    echo -e "     - NVIDIA_VISIBLE_DEVICES=all"
    echo -e "     - NVIDIA_DRIVER_CAPABILITIES=compute,utility"
    echo -e "${YELLOW}4. Deploy with GPU (RTX 4090 or better recommended)${NC}"
    echo -e "${YELLOW}5. Access via HTTP service on port 8004${NC}"
    echo ""
    echo -e "${GREEN}🚀 Ready for RunPod deployment!${NC}"
else
    echo -e "${RED}❌ Failed to push to Docker Hub!${NC}"
    exit 1
fi
