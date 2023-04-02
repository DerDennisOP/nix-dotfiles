{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs

    # Development tools

    # Languages

    # Desktop programs
    bitwarden
    firefox
    lutris
    protonup-qt
    teamspeak5_client

    # Python packages

    # Libraries

    # Drivers
    cudatoolkit

    # Desktop environment
    conky
    lightly-qt
    latte-dock
    ulauncher

    # Windows
  ];
}
