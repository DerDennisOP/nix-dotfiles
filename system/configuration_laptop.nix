# wiki/wiki/Main_Page
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
in {
  imports =
    [
      ./hardware-configuration_laptop.nix
      ./configuration.nix
      ./program_laptop.nix
      ./program.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  networking = {
    hostName = "DennisLaptop"; # Define your hostname.
    networkmanager.enable = true;
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    sensor.iio.enable = true;
  };
  
  programs.zsh.shellAliases = {
    nixedit = "nvim ~/dotfiles/system/configuration_main.nix";
    nixeditp = "nvim ~/dotfiles/system/program_main.nix";
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

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      layout = "de";
    };

    # fprintd.enable = true;

    # Custom udev rules
    udev.extraRules = "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"03e7\", MODE=\"0666\"\n";
    udev.extraHwdb = ''
      sensor:modalias:acpi:INVN6500*:dmi:*svn*ASUSTeK*:*pn*TP300LA*
      ACCEL_MOUNT_MATRIX=0, 1, 0; 1, 0, 0; 0, 0, 1
    '';
  };

  security = {
  #  pam.services = {
  #    login.fprintAuth = true;
  #    xscreensaver.fprintAuth = true;
  #  };
  #  rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
}
