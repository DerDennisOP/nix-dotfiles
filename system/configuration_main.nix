# wiki/wiki/Main_Page
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
in {
  imports =
    [
      ./hardware-configuration_main.nix
      ./configuration.nix
      ./program_main.nix
      ./program.nix
    ];

  # Bootloader.
  boot = {
    supportedFilesystems = [ "zfs" ];
    tmpOnTmpfs = true;
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    zfs = {
      enableUnstable = true;
      devNodes = "/dev/";
      forceImportRoot = true;
    };
    loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/efis/nvme0n1p1";
      };
      generationsDir.copyKernels = true;
      grub = {
        enable = true;
        copyKernels = true;
        zfsSupport = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
	fsIdentifier = "uuid";
	device = "nodev";
	extraInstallCommands = "[ ! -e /boot/efis/nvme0n1p1/EFI ] || cp -r /boot/efis/nvme0n1p1/EFI/* /boot/efis/nvme0n1p1/";
      };
    };
  };

  fileSystems."/".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/boot".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/home".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/var/lib".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/var/log".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/boot/efis/nvme0n1p1".options = [ "x-systemd.idle_timeout=1min" "x-systemd.automount" "nomount" "nofail" "noatime" "X-mount.mkdir" ];

  networking = {
    hostName = "DennisMain"; # Define your hostname.
    hostId = "3457acd3";
    networkmanager.enable = true;
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
  };

  programs = {
    steam.enable = true;
    zsh.shellAliases = {
      nixedit = "nvim ~/dotfiles/system/configuration_main.nix";
      nixeditp = "nvim ~/dotfiles/system/program_main.nix";
    };
  };

  services = {
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;

      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;

      layout = "de";
    };

    # Custom udev rules
    udev.extraRules = "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"03e7\", MODE=\"0666\"\n";
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };
}
