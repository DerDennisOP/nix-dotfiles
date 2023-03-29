## wiki/wiki/Main_Page# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
#  makeDesktopItem = import ../build-support/make-desktopitem {
#    inherit stdenv;
#  };

#  msWordDesktopItem = makeDesktopItem {
#    name = "msWord";
#    desktopName = "Word";
#    exec = "google-chrome-stable -kiosk https://wavelens.io";
#    terminal = "true";
#  };
#in {
#  home.packages = [
#    msWordDesktopItem
#  ];
#}

in {
  imports =
    [
      ./hardware-configuration.nix
      ./systemprograms.nix
    ];

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_5_15;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  networking.hostName = "DennisLaptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.utf8";

  # enable Font folder
  fonts.fontDir.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    sensor.iio.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dennis = {
    isNormalUser = true;
    description = "Dennis Wuitz";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  firefox
    #  thunderbird
    ];
  };

  services = {
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable automatic login for the user.
    xserver = {
      enable = true;

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      layout = "de";
      xkbVariant = "";
    };

    fprintd.enable = true;

    # Custom udev rules
    udev.extraRules = "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"03e7\", MODE=\"0666\"\n";
  };

  security = {
    pam.services = {
      login.fprintAuth = true;
      xscreensaver.fprintAuth = true;
    };
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
        strategy = [ "completion" ];
        async = true;
      };
      syntaxHighlighting.enable = true;
      zsh-autoenv.enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "sudo" "docker" "kubectl" "history" "colorize" "direnv"];
        theme = "agnoster";
      };
      shellAliases = {
        l = "ls -l -a";
        update = "sudo nixos-rebuild switch --flake ~/dotfiles/";
        garbage = "sudo nix-collect-garbage -d";
        nixedit = "nvim ~/dotfiles/system/configuration.nix";
        nixeditp = "nvim ~/dotfiles/system/systemprograms.nix";
	pipi = "pip install --user";
	v = "nvim";
	countpy = "find . -name '*.py' | xargs  wc -l";
      };
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd
        glib
        libglvnd
      ];
    };
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-14.2.9"
  ];

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-oder-than 14d";
    };
  };
}
