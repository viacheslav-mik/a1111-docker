variable "REGISTRY" {
    default = "docker.io"
}

variable "REGISTRY_USER" {
    default = "suzzwke"
}

variable "RELEASE" {
    default = "1.0.0"
}

variable "BASE_IMAGE_REPOSITORY" {
    default = "suzzwke/runpod-base"
}

variable "BASE_IMAGE_VERSION" {
    default = "1.0.0"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["${REGISTRY}/${REGISTRY_USER}/stable-diffusion:${RELEASE}"]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "suzzwke/runpod-base:1.0.0-python3.10-cuda12.1.1-torch2.1.2"
        APP_MANAGER_VERSION = "1.2.1",
        KOHYA_VERSION = "v24.1.7",
        KOHYA_TORCH_VERSION = "2.1.2+cu121",
        KOHYA_XFORMERS_VERSION = "0.0.23.post1",
        KOHYA_INDEX_URL = "https://download.pytorch.org/whl/cu121",
        WEBUI_VERSION="v1.10.0"
        WEBUI_TORCH_VERSION="2.4.0+cu121"
        WEBUI_XFORMERS_VERSION="0.0.27.post2"
        WEBUI_INDEX_URL="https://download.pytorch.org/whl/cu121"
    }
}
