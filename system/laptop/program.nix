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
    rocmPackages.rocminfo

    # Games
    mindustry-wayland

    # Windows
    wineWowPackages.waylandFull
  ];
}
