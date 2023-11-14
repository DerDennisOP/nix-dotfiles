{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs
    gource
    nvitop

    # Development tools

    # Languages

    # Desktop programs
    bitwarden
    firefox
    teamspeak5_client

    # Python packages
    python310Packages.torch-bin

    # Libraries
    cudaPackages.cudnn

    # Drivers
    cudatoolkit

    # Desktop environment

  ];
}
