{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs
    gource

    # Development tools

    # Languages

    # Desktop programs
    bitwarden
    firefox
    lutris
    protonup-qt
    teamspeak5_client

    # Python packages
    python310Packages.torch-bin

    # Libraries
    cudaPackages.cudnn

    # Drivers
    cudatoolkit
    openhmd

    # Desktop environment

    # Windows
    virtmanager
  ];
}
