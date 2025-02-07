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
        KOHYA_VERSION = "v24.1.7"
    }
}
