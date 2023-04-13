{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI programs

    # Development tools

    # Languages

    # Desktop programs
    adobe-reader
    bitwarden
    firefox
    lutris
    protonup-qt
    teamspeak5_client
    whatsapp-for-linux

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
