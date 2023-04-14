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
    lsof
    neofetch
    nix-init
    nix-prefetch
    nixpkgs-fmt
    nmap
    pciutils
    ripgrep
    tig
    tree
    unzip
    ventoy-bin
    wget
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
