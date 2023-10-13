{ pkgs, ... }:
let
in {
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
    ./program.nix
    ../program.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      kernelModules = [ "amdgpu" ];
      luks = {
        #fido2Support = true;
        devices."cryptroot" = {
          device = "/dev/disk/by-uuid/4964c656-c64a-490a-a181-ec348874bd7f";
          #crypttabExtraOpts = ["fido2-device=auto"];
          #fido2 = {
            #publicKey = ../yubikey.pub;
            #encryptedPass = ../yubikey.asc;
            #passwordLess = true;
            #gracePeriod = 10;
            #credential = "7d9ee873a05fdd7dec02481d5677d028a9b48f624d90718f2be23e4fe28ba27b3ebf8d8ba5eeeb38c817fa099ef72c0e";
          #};
        };
      };
    };
  };

  networking = {
    hostId = "a298ad87";
    hostName = "DennisLaptop"; # Define your hostname.
    networkmanager.enable = true;
    #firewall.enable = false;
    #firewall.allowedTCPPorts = [ 8000 ];
  };

  c3d2.audioStreaming = true;

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    sensor.iio.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        rocmPackages.clr
        rocmPackages.clr.icd
      ];
    };
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    zsh.shellAliases = {
      nixedit = "nvim ~/dotfiles/system/laptop/configuration.nix";
      nixeditp = "nvim ~/dotfiles/system/laptop/program.nix";
      nixedith = "nvim ~/dotfiles/system/laptop/hardware-configuration.nix";
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

      videoDrivers = [ "amdgpu" ];

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
    sudo.wheelNeedsPassword = true;
  };
}
