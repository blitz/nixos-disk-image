{ config, lib, pkgs, modulesPath, ... }:
let
  rootLabel = "nixos-ooShoo7B";
in
{
  imports = [
    # Add other modules here.
  ];

  config = {
    boot.growPartition = true;

    fileSystems."/" = {
      device = "/dev/disk/by-label/${rootLabel}";
      fsType = "ext4";
      autoResize = true;
    };

    # For UEFI. It's unfortunate that the ESP disk label is hardcoded.
    #
    # fileSystems."/boot" = {
    #   device = "/dev/disk/by-label/ESP";
    #   fsType = "vfat";
    # };

    boot.loader.grub = {
      # For Legacy Boot
      device = "/dev/vda";

      # For UEFI boot
      #device = "nodev";
      #efiSupport = true;
      #efiInstallAsRemovable = true;
    };

    system.build.raw = let
      makeDiskImage = import "${toString modulesPath}/../lib/make-disk-image.nix";
    in
      makeDiskImage {
        inherit lib config pkgs;

        # For UEFI
        #partitionTableType = "efi";

        diskSize = 2048;
        format = "raw";
        label = rootLabel;

        bootSize = "512M";
      };
  };
}
