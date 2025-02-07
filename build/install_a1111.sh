#!/usr/bin/env bash
set -e

WEBUI_VERSION="v1.10.0"
TORCH_VERSION="2.4.0+cu121"
XFORMERS_VERSION="0.0.27.post2"
INDEX_URL="https://download.pytorch.org/whl/cu121"

# Clone the git repo of the Stable Diffusion Web UI by Automatic1111
# and set version
cd "/workspace"
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
git checkout tags/${WEBUI_VERSION}

# Create and activate venv
python3 -m venv --system-site-packages /workspace/stable-diffusion-webui/venv
source /workspace/stable-diffusion-webui/venv/bin/activate

# Install torch and xformers
pip3 install --no-cache-dir torch==${TORCH_VERSION} torchvision torchaudio --index-url ${INDEX_URL}
pip3 install --no-cache-dir xformers==${XFORMERS_VERSION} --index-url ${INDEX_URL}

# Install A1111
pip3 install -r requirements_versions.txt
python3 -c "from launch import prepare_environment; prepare_environment()" --skip-torch-cuda-test
