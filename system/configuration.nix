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
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

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

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    #services.xserver.windowManager.i3.enable = true;
#    windowManager.xmonad = {
#        enable = true;
#        enableContribAndExtras = true;
#      };
#    windowManager.default = "xmonad";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # enable Font folder
  fonts.fontDir.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  hardware.sensor.iio.enable = true;

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

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "dennis";

  services.fprintd.enable = true;

  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;

  security.sudo.wheelNeedsPassword = false;

  # Custom udev rules
  services.udev.extraRules = "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"03e7\", MODE=\"0666\"\n";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.zsh = {
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
      update = "sudo nixos-rebuild switch --flake ~/dotfiles/ --recreate-lock-file";
      garbage = "sudo nix-collect-garbage -d";
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    opencl-headers
    ocl-icd
    rocm-opencl-runtime
    rocminfo
    rocm-opencl-icd
    opencascade
    htop
    wpsoffice
    audacity
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    geogebra6
    gjs
    gnome-network-displays
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnome-randr
    remmina
    zsh-nix-shell
    thunderbird
    cowsay
    perl
    winetricks
    samba
    hugo
    wine
    wineWowPackages.waylandFull
    libfprint
    iio-sensor-proxy
    futhark
    mesa
    libGL
    meson
    sass
    ntfs3g
    ninja
    xorg.libX11
    libtiff
    gcc
    gpp
    gnome-themes-extra
    git
    nodejs
    vscode
    vlc
    discord
    gimp
    #github-desktop
    nextcloud-client
    python310
    python310Packages.pip
    lorien
    gnome.gnome-themes-extra
    google-chrome
    nodePackages.npm
    nodePackages.ts-node
    wget
    gnumake
    cmake
    usbutils
    usbtop
    usb-reset
    nmap
    blender
    anydesk
    jre8
    libgccjit
    zlib
    pulseaudio
    opencv4
    python310Packages.numpy
    jp2a
    linux-wifi-hotspot
    unzip
    etcher
    darktable
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
