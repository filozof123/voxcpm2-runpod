FROM runpod/pytorch:1.0.2-cu1281-torch280-ubuntu2404

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONUNBUFFERED=1 \
    HF_HOME=/opt/hf_cache \
    HUGGINGFACE_HUB_CACHE=/opt/hf_cache/hub \
    PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True \
    VOXCPM_DEVICE=cuda \
    VOXCPM_PORT=8808

RUN apt-get update && apt-get install -y --no-install-recommends \
    git ffmpeg curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

ARG VOXCPM_REF=f0c787f09
RUN git clone https://github.com/OpenBMB/VoxCPM.git /opt/VoxCPM \
    && cd /opt/VoxCPM \
    && git checkout "${VOXCPM_REF}" \
    && python -m pip install --upgrade pip \
    && pip install -e .

COPY preload_models.py /opt/preload_models.py
RUN python /opt/preload_models.py

COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /opt/VoxCPM
EXPOSE 8808

HEALTHCHECK --interval=15s --timeout=5s --start-period=90s --retries=10 \
  CMD curl -fsS http://127.0.0.1:8808/ >/dev/null || exit 1

ENTRYPOINT ["/start.sh"]
