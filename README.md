# VoxCPM2 RunPod Ready Image

Goal: make VoxCPM2 behave like a prebuilt ComfyUI RunPod template.

User flow:

Deploy Pod -> cold start -> Connect to port 8808 -> VoxCPM2 Web UI

There is no normal-use installation step.

## Build

From this directory:

```bash
docker build -t YOUR_REGISTRY/voxcpm2-runpod:latest .
docker push YOUR_REGISTRY/voxcpm2-runpod:latest
```

Then create a RunPod custom template that uses the pushed image and exposes HTTP port 8808.

## What is included

- RunPod PyTorch 2.8 / CUDA 12.8 base
- OpenBMB VoxCPM code pinned to the tested revision
- Python dependencies
- openbmb/VoxCPM2 model cache
- iic/SenseVoiceSmall
- iic/speech_zipenhancer_ans_multiloss_16k_base
- Automatic start of the official Gradio Web UI on port 8808

## What is intentionally NOT included yet

- Experimental KV-cache enlargement
- Automatic 2–3 minute long-text segmentation and lossless joining
- Custom narrator presets
- Multi-GPU parallel segment generation

Those should be added after the base one-click image is confirmed stable.
