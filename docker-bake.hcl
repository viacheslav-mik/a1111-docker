variable "USERNAME" {
    default = "ashleykza"
}

variable "APP" {
    default = "a1111"
}

variable "RELEASE" {
    default = "1.8.0"
}

variable "CU_VERSION" {
    default = "118"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["${USERNAME}/${APP}:${RELEASE}"]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "ashleykza/runpod-base:1.0.1-cuda11.8.0-torch2.1.2"
        INDEX_URL = "https://download.pytorch.org/whl/cu${CU_VERSION}"
        TORCH_VERSION = "2.1.2+cu${CU_VERSION}"
        XFORMERS_VERSION = "0.0.23.post1+cu${CU_VERSION}"
        WEBUI_VERSION = "v1.8.0"
        CONTROLNET_COMMIT = "eb451a007f7040288e865f96e9ee0842aa6ef91c"
        CIVITAI_BROWSER_PLUS_VERSION = "v3.5.2"
        APP_MANAGER_VERSION = "1.0.2"
        CIVITAI_DOWNLOADER_VERSION = "2.1.0"
        VENV_PATH = "/workspace/venvs/stable-diffusion-webui"
    }
}
