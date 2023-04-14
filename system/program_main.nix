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
    openhmd

    # Desktop environment

    # Windows
    libvirt
    qemu_full
    wine
    win-qemu
    virt-manager
  ];
}
