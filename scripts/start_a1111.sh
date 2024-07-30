#!/usr/bin/env bash
echo "A1111: Starting Stable Diffusion Web UI"
cd /workspace/stable-diffusion-webui
export PYTHONUNBUFFERED=1
nohup ./webui.sh -f > /workspace/logs/webui.log 2>&1 &
echo "A1111: Stable Diffusion Web UI started"
echo "A1111: Log file: /workspace/logs/webui.log"
