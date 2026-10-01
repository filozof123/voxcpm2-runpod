import os

os.environ.setdefault("HF_HOME", "/opt/hf_cache")
os.environ.setdefault("HUGGINGFACE_HUB_CACHE", "/opt/hf_cache/hub")

print("Preloading openbmb/VoxCPM2 into Docker image...")
from huggingface_hub import snapshot_download as hf_snapshot_download
hf_path = hf_snapshot_download("openbmb/VoxCPM2")
print("VoxCPM2:", hf_path)

print("Preloading SenseVoiceSmall...")
from modelscope import snapshot_download as ms_snapshot_download
sense = ms_snapshot_download("iic/SenseVoiceSmall")
print("SenseVoiceSmall:", sense)

print("Preloading ZipEnhancer...")
enhancer = ms_snapshot_download("iic/speech_zipenhancer_ans_multiloss_16k_base")
print("ZipEnhancer:", enhancer)

print("All model assets are baked into the image.")
