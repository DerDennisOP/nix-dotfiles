{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs
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
    neofetch
    nix-init
    nix-prefetch
    nixpkgs-fmt
    nmap
    pciutils
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
    postman
    signal-desktop
    rustup
    vscode

    # Languages
    futhark
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
    discord
    geogebra6
    gimp
    google-chrome
    gparted
    nextcloud-client
    spotify
    thunderbird
    vlc
    wpsoffice

    # Python packages
    python310
    python310Packages.numpy
    python310Packages.pip

    # Drivers
    samba
    usbtop
    usbutils
    usb-reset

    # Desktop environment

    # Windows
    winetricks
    wine

    # YubiKey
    yubikey-manager-qt
    yubikey-personalization
  ];
}
