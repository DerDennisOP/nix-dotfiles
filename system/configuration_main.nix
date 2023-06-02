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
    tmp.useTmpfs = true;
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [ "kvm-amd" "nordrand" ];
    zfs = {
      enableUnstable = true;
      devNodes = "/dev/disk/by-id/";
      forceImportRoot = true;
    };
    loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/efis/nvme-Samsung_SSD_980_PRO_1TB_S5GXNF0W178262L-part1";
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
        extraInstallCommands = "[ ! -e /boot/efis/nvme-Samsung_SSD_980_PRO_1TB_S5GXNF0W178262L-part1/EFI ] || cp -r /boot/efis/nvme-Samsung_SSD_980_PRO_1TB_S5GXNF0W178262L-part1/EFI/* /boot/efis/nvme-Samsung_SSD_980_PRO_1TB_S5GXNF0W178262L-part1";
      };
    };
  };

  virtualisation.libvirtd.enable = true;

  fileSystems."/".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/boot".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/home".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/var/lib".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/var/log".options = [ "X-mount.mkdir" "noatime" ];
  fileSystems."/boot/efis/nvme-Samsung_SSD_980_PRO_1TB_S5GXNF0W178262L-part1".options = [ "x-systemd.idle_timeout=1min" "x-systemd.automount" "nomount" "nofail" "noatime" "X-mount.mkdir" ];

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
    enableAllFirmware = true;
    steam-hardware.enable = true;
    pulseaudio.enable = false;
    opengl.enable = true;
    opengl.driSupport = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  programs = {
    dconf.enable = true;
    droidcam.enable = true;
    steam.enable = true;
    zsh.shellAliases = {
      nixedit = "nvim ~/dotfiles/system/configuration_main.nix";
      nixeditp = "nvim ~/dotfiles/system/program_main.nix";
      nixedith = "nvim ~/dotfiles/system/hardware-configuration_main.nix";
    };
    
    #nix-ld = {
    #  enable = true;
    #  libraries = with pkgs; [
    #    linuxKernel.packages.linux_6_2.nvidia_x11
    #  ];
    #};
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xmr-stak.cudaSupport = true;

    xserver = {
      enable = true;

      videoDrivers = [ "nvidia" ];

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      layout = "de";
    };

    udev.extraRules = "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"03e7\", MODE=\"0666\"\n";
  };
  #qt.enable = true;

  security = {
    sudo.wheelNeedsPassword = true;
  };
}
