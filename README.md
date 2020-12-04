# Minimal Disk Image Example

This repository contains a minimal example of building a bootable disk
image with Nix.

To build a legacy boot image, do the following:

```sh
% nix-build -A legacy
...

% pv result/nixos.img > /dev/YOUR-USB-STICK
```
