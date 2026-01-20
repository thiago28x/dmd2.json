# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail rgthree-comfy@1.0.2512112053 --mode remote
RUN comfy node install --exit-on-fail cg-use-everywhere@7.5.2
RUN comfy node install --exit-on-fail comfyui-glifnodes@1.0.2
RUN comfy node install --exit-on-fail comfyui_ultimatesdupscale@1.6.2
RUN comfy node install --exit-on-fail comfyui-impact-pack@8.28.2
RUN comfy node install --exit-on-fail comfyui-impact-subpack@1.3.5
RUN comfy node install --exit-on-fail comfyui-inpaint-cropandstitch@3.0.2
RUN comfy node install --exit-on-fail comfyui_essentials@1.1.0
# Unknown-registry nodes: clone from GitHub when aux_id provided
RUN git clone https://github.com/ChenDarYen/ComfyUI-NAG /comfyui/custom_nodes/ComfyUI-NAG
# Could not resolve other unknown_registry nodes without aux_id (PrimitiveNode, Fast Groups Bypasser (rgthree), Note, etc.)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/tianweiy/DMD2/resolve/main/dmd2_sdxl_4step_lora.safetensors --relative-path models/loras --filename dmd2_sdxl_4step_lora.safetensors
RUN comfy model download --url https://huggingface.co/notkenski/upscalers/blob/main/1xSkinContrast-High-SuperUltraCompact.pth --relative-path models/upscale_models --filename 1xSkinContrast-High-SuperUltraCompact.pth
RUN comfy model download --url https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt --relative-path models/ultralytics/bbox --filename hand_yolov8s.pt
RUN comfy model download --url https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth --relative-path models/sam --filename sam_vit_b_01ec64.pth
RUN comfy model download --url https://huggingface.co/uwg/upscaler/blob/main/ESRGAN/1x-ITF-SkinDiffDetail-Lite-v1.pth --relative-path models/upscale_models --filename 1x-ITF-SkinDiffDetail-Lite-v1.pth
RUN comfy model download --url https://huggingface.co/minaiosu/silvermoong/blob/main/748cmXL_NBVP1_lokr_V6311PZ.safetensors --relative-path models/loras --filename 748cmXL_NBVP1_lokr_V6311PZ.safetensors
RUN comfy model download --url https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt --relative-path models/ultralytics/bbox --filename face_yolov8m.pt
RUN comfy model download --url https://huggingface.co/JCTN/UPSCALER_JCTN/blob/main/4xNMKDSuperscale_4xNMKDSuperscale.pt --relative-path models/upscale_models --filename 4xNMKDSuperscale_4xNMKDSuperscale.pt
# RUN # Could not find URL for lustify_7.safetensors (filename: lustify_7.safetensors)

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
