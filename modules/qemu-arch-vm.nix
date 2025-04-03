{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    qemu
  ];
  xdg.desktopEntries = {
    "arch-qemu-vm" = {
      name = "Arch Linux";
      icon = "qemu";
      # icon = "${pkgs.qemu}/share/icons/hicolor/scalable/apps/qemu.svg";
      terminal = true;
      exec = "${pkgs.writeShellScript "qemu-arch" ''
        "${pkgs.qemu}/bin/qemu-system-x86_64" \
          -monitor stdio \
          -enable-kvm \
          -cpu host \
          -smp cores=4,threads=4,sockets=1 \
          -vga virtio \
          -m 12G \
          -machine q35 \
          -usb -device usb-tablet \
          -boot d \
          -cdrom ${config.home.homeDirectory}/Downloads/archlinux-2025.03.01-x86_64.iso \
          ${config.home.homeDirectory}/.local/share/qemu-img/image_file_2
      ''}";
    };
  };
}
