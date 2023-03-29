{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs
    cowsay
    direnv
    htop
    jp2a
    nixpkgs-fmt
    nmap
    tree
    unzip
    wget
    zsh-nix-shell
    # Development tools
    cmake
    etcher
    gcc
    git
    gnumake
    gpp
    jre8
    neovim
    postgresql
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
    thunderbird
    vlc
    wpsoffice
    # Python packages
    python310
    python310Packages.numpy
    python310Packages.pip
    # Libraries
    libgccjit
    libtiff
    opencl-headers
    opencascade
    opencv4
    portaudio
    pulseaudio
    xorg.libX11
    zlib
    # Drivers
    iio-sensor-proxy
    libfprint
    libGL
    mesa
    ntfs3g
    ocl-icd
    rocminfo
    rocm-opencl-runtime
    rocm-opencl-icd
    samba
    usbtop
    usbutils
    usb-reset
    # Desktop environment
    gjs
    gnome-network-displays
    gnome-themes-extra
    gnome-randr
    gnome.gnome-themes-extra
    gnome.gnome-tweaks
    gnome.dconf-editor
    # Windows
    winetricks
    wine
    wineWowPackages.waylandFull
  ];
}
