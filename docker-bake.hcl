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
        INDEX_URL = "https://download.pytorch.org/whl/cu${CU_VERSION}"
        TORCH_VERSION = "2.1.2+cu${CU_VERSION}"
        XFORMERS_VERSION = "0.0.23.post1+cu${CU_VERSION}"
        CONTROLNET_COMMIT = "0b90426254debf78bfc09d88c064d2caf0935282"
        WEBUI_VERSION = "v1.8.0"
        RUNPODCTL_VERSION = "v1.14.2"
        VENV_PATH = "/workspace/venvs/stable-diffusion-webui"
    }
}
