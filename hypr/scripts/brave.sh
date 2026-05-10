#!/bin/bash
# Brave wrapper para evitar flickering en NVIDIA Wayland
/usr/bin/brave-browser --disable-gpu-memory-buffer-video-frames "$@"