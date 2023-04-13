{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs
    cowsay
    deadnix
    direnv
    fd
    file
    htop
    jp2a
    licensee
    neofetch
    nixpkgs-fmt
    nix-init
    nix-prefetch
    nmap
    pciutils
    ripgrep
    tree
    unzip
    wget
    ventoy-bin
    zoxide
    zsh-nix-shell

    # Nix Extensions
    nix-output-monitor

    # Development tools
    cmake
    etcher
    gcc
    gnumake
    gpp
    jre8
    mariadb
    postman
    postgresql
    postman
    vscode
    
    # Languages
    futhark
    go
    nodejs
    nodePackages.npm
    nodePackages.ts-node
    perl

    # Desktop programs
    anydesk
    audacity
    blender
    darktable
    discord
    geogebra6
    gimp
    google-chrome
    nextcloud-client
    spotify
    teams
    thunderbird
    vlc
    wpsoffice

    # Python packages
    python310
    python310Packages.numpy
    python310Packages.pip

    # Libraries
    libgccjit
    libmysqlclient
    libtiff
    opencl-headers
    opencascade
    opencv4
    portaudio
    pulseaudio
    xorg.libX11
    zlib

    # Drivers
    libGL
    ntfs3g
    ocl-icd
    samba
    usbtop
    usbutils
    usb-reset

    # Desktop environment

    # Windows
    winetricks
    wine
  ];
}
