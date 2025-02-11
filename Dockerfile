ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN mkdir /sd-models
RUN mkdir /workspace

# Copy the build scripts
WORKDIR /
COPY --chmod=755 build/* ./

# Install A1111
ARG WEBUI_VERSION
ARG WEBUI_TORCH_VERSION
ARG WEBUI_XFORMERS_VERSION
ARG WEBUI_INDEX_URL
WORKDIR /workspace
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
WORKDIR /workspace/stable-diffusion-webui
RUN git checkout tags/${WEBUI_VERSION}
RUN python3 -m venv --system-site-packages /workspace/stable-diffusion-webui/venv && \
    source /workspace/stable-diffusion-webui/venv/bin/activate
RUN pip3 install --no-cache-dir torch==${WEBUI_TORCH_VERSION} torchvision torchaudio --index-url ${WEBUI_INDEX_URL}
RUN pip3 install --no-cache-dir xformers==${WEBUI_XFORMERS_VERSION} --index-url ${WEBUI_INDEX_URL}
RUN pip3 install -r requirements_versions.txt
RUN python3 -c "from launch import prepare_environment; prepare_environment()" --skip-torch-cuda-test

# Install Kohya_ss
ARG KOHYA_VERSION
ARG KOHYA_TORCH_VERSION
ARG KOHYA_XFORMERS_VERSION
ARG KOHYA_INDEX_URL
RUN git clone https://github.com/bmaltais/kohya_ss.git /workspace/kohya_ss && \
    cd /workspace/kohya_ss && \
    git checkout ${KOHYA_VERSION} && \
    git submodule update --init --recursive
COPY kohya_ss/* /workspace/kohya_ss
WORKDIR /workspace/kohya_ss
RUN python3 -m venv --system-site-packages /workspace/kohya_ss/venv && \
    source /workspace/kohya_ss/venv/bin/activate && \
    pip3 install torch==${KOHYA_TORCH_VERSION} torchvision torchaudio --index-url ${KOHYA_INDEX_URL} && \
    pip3 install xformers==${KOHYA_XFORMERS_VERSION} --index-url ${KOHYA_INDEX_URL} && \
    pip3 install bitsandbytes==0.43.0 \
        tensorboard==2.15.2 tensorflow==2.15.0.post1 \
        wheel packaging tensorrt && \
    pip3 install tensorflow[and-cuda] && \
    pip3 install -r requirements.txt

# Install Application Manager
WORKDIR /
ARG APP_MANAGER_VERSION
RUN git clone https://github.com/ashleykleynhans/app-manager.git /app-manager && \
    cd /app-manager && \
    git checkout tags/${APP_MANAGER_VERSION} && \
    npm install
COPY app-manager/config.json /app-manager/public/config.json

# Copy Stable Diffusion Web UI config files
COPY a1111/relauncher.py a1111/webui-user.sh a1111/config.json a1111/ui-config.json /workspace/stable-diffusion-webui/

# ADD SDXL styles.csv
ADD https://raw.githubusercontent.com/Douleb/SDXL-750-Styles-GPT4-/main/styles.csv /workspace/stable-diffusion-webui/styles.csv

# NGINX Proxy
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Set template version
ARG RELEASE
ENV TEMPLATE_VERSION=${RELEASE}

# Copy the scripts
WORKDIR /
COPY --chmod=755 scripts/* ./

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]
