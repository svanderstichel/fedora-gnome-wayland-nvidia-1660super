#!/bin/bash

# Actualizar el kernel con los argumentos de grub /etc/default/grub
sudo grubby --args="nvidia-drm.modeset=1 nvidia-drm.fbdev=1 nvidia.NVreg_EnableGpuFirmware=0" --update-kernel=ALL

# Agregar opciones al archivo de configuración de nvidia
echo "options nvidia NVreg_EnableGPUFirmware=0" | sudo tee -a /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf
echo "options nvidia_drm fbdev=1" | sudo tee -a /etc/modprobe.d/nvidia.conf

# Deshabilitar modulo USB-C NVidia
echo "blacklist i2c_nvidia_gpu" >> /etc/modprobe.d/blacklist_i2c-nvidia-gpu.conf
grub2-mkconfig -o /boot/grub2/grub.cfg

reboot
