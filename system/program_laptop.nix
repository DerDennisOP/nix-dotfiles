{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs

    # Development tools

    # Languages

    # Desktop programs
    krita

    # Python packages

    # Libraries

    # Drivers
    iio-sensor-proxy
    libfprint
    mesa
    rocminfo
    rocm-opencl-runtime
    rocm-opencl-icd

    # Desktop environment
    gjs
    gnome-network-displays
    gnome-themes-extra
    gnome-randr
    gnome.gnome-themes-extra
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnomeExtensions.screen-rotate

    # Windows
    wineWowPackages.waylandFull
  ];
}
