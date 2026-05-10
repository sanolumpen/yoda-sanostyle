#!/bin/bash
# Discord wrapper para evitar flickering en NVIDIA Wayland
# Usa --use-gl=desktop que fuerza OpenGL de escritorio

discord --use-gl=desktop "$@"