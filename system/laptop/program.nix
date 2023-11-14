{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs

    # Development tools

    # Languages

    # Desktop programs
    freecad
    kicad
    krita
    xournalpp

    # Python packages

    # Drivers
    iio-sensor-proxy
    rocmPackages.rocminfo

    # Games
    mindustry-wayland
    zeroadPackages.zeroad-unwrapped

    # Windows
    wineWowPackages.waylandFull
  ];
}
