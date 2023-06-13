{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs

    # Development tools

    # Languages

    # Desktop programs
    freecad
    krita
    xournalpp

    # Python packages

    # Drivers
    iio-sensor-proxy
    rocminfo

    # Desktop environment
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
