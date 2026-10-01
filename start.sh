#!/usr/bin/env bash
set -euo pipefail
cd /opt/VoxCPM

echo "=================================================="
echo " VoxCPM2 RunPod Ready Image"
echo " Port: ${VOXCPM_PORT:-8808}"
echo " Device: ${VOXCPM_DEVICE:-cuda}"
echo "=================================================="

nvidia-smi || true

exec python app.py \
  --host 0.0.0.0 \
  --port "${VOXCPM_PORT:-8808}" \
  --device "${VOXCPM_DEVICE:-cuda}"
