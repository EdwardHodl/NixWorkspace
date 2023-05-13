#!/bin/sh
##
## Add or Update the nixos-hardware channel
## see: https://github.com/NixOS/nixos-hardware

##  Then import an appropriate profile path from the table below. For example, to enable ThinkPad X220 profile, your imports in /etc/nixos/configuration.nix should look like:
# imports = [
#   <nixos-hardware/lenovo/thinkpad/x220>
#     ./hardware-configuration.nix
#     ];

sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --update
