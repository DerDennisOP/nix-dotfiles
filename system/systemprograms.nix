{ pkgs, ... }:
{
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    go
    opencl-headers
    ocl-icd
    rocm-opencl-runtime
    rocminfo
    rocm-opencl-icd
    opencascade
    htop
    postgresql
    wpsoffice
    audacity
    neovim
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
    portaudio
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
}
