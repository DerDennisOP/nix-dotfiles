{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs
    bat
    btop
    comma
    cowsay
    deadnix
    direnv
    fd
    ffmpeg_5-full
    file
    htop
    jp2a
    jq
    licensee
    lsof
    ncpamixer
    neofetch
    nix-init
    nix-prefetch
    nixpkgs-fmt
    nmap
    pciutils
    qrencode
    ripgrep
    tig
    tokei
    tree
    unzip
    ventoy
    wget
    zoxide
    zsh-nix-shell

    # Nix Extensions
    nix-output-monitor

    # Development tools
    cargo
    cmake
    etcher
    gcc
    gnumake
    gpp
    jre8
    mariadb
    postgresql
    #postman
    rustup
    signal-desktop
    vscode

    # Languages
    # futhark
    go
    nodePackages.npm
    nodePackages.ts-node
    nodejs
    perl
    rustc

    # Desktop programs
    anydesk
    audacity
    blender
    darktable
    dino
    discord
    geogebra6
    gimp
    google-chrome
    gparted
    nextcloud-client
    spotify
    thunderbird
    todoist-electron
    vlc
    wpsoffice

    # Python packages
    python310
    python310Packages.numpy
    python310Packages.pip

    # Drivers
    samba
    usb-reset
    usbtop
    usbutils

    # Desktop environment
    gnome-extension-manager
    gnome-network-displays
    gnome-randr
    gnome-themes-extra   
    gnome.dconf-editor
    gnome.gnome-themes-extra
    gnome.gnome-tweaks
    gnomeExtensions.screen-rotate
    nerdfonts

    # Windows
    wine
    winetricks

    # YubiKey
    yubikey-manager-qt
    yubikey-personalization
  ];
}
