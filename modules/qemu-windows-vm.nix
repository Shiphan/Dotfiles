{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    qemu
    # OVMF
    # swtpm
  ];
  xdg.desktopEntries = {
    "windows-10" = {
      name = "Windows 10";
      icon = "qemu";
      # icon = "${pkgs.qemu}/share/icons/hicolor/scalable/apps/qemu.svg";
      terminal = true;
      exec = "${pkgs.writeShellScript "qemu-windows-11" ''
        "${pkgs.qemu}/bin/qemu-system-x86_64" \
          -monitor stdio \
          -enable-kvm \
          -cpu host \
          -vga virtio \
          -m 12G \
          -machine q35 \
          -usb -device usb-tablet \
          -boot d \
          -cdrom ${config.home.homeDirectory}/Downloads/Win10_22H2_Chinese_Traditional_x64v1.iso \
          ${config.home.homeDirectory}/.local/share/qemu-img/image_file_1
      ''}";
    };
    # FIXME: windows 11 vm not work
    /*
      "windows-11" = {
        name = "Windows 11";
        icon = "qemu";
        # icon = "${pkgs.qemu}/share/icons/hicolor/scalable/apps/qemu.svg";
        terminal = true;
        exec = "${pkgs.writeShellScript "qemu-windows-11" ''
          # cp -n ${pkgs.OVMF.fd}/FV/OVMF_CODE.fd ${config.home.homeDirectory}/.local/share/qemu-img/OVMF_VARS.fd
          # chmod +w ${config.home.homeDirectory}/.local/share/qemu-img/OVMF_VARS.fd

          # swtpm socket --tpm2 --tpmstate dir=${config.home.homeDirectory}/.local/share/qemu-img/tpm --ctrl type=unixio,path=${config.home.homeDirectory}/.local/share/qemu-img/tpm/swtpm-sock &

          qemu-system-x86_64 \
            -monitor stdio \
            -enable-kvm \
            -cpu host \
            -vga virtio \
            -m 12G \
            -machine q35 \
            -device amd-iommu \
            -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
            -chardev socket,id=chrtpm,path=${config.home.homeDirectory}/.local/share/qemu-img/tpm/swtpm-sock \
            -tpmdev emulator,id=tpm0,chardev=chrtpm \
            -device tpm-tis,tpmdev=tpm0 \
            -boot d \
            -cdrom ${config.home.homeDirectory}/Downloads/Win10_22H2_Chinese_Traditional_x64v1.iso \
            ${config.home.homeDirectory}/.local/share/qemu-img/image_file_1

            # -boot menu=on \
            # -cdrom ${config.home.homeDirectory}/Downloads/Win11_24H2_Chinese_Traditional_x64.iso \
            # -cdrom ${config.home.homeDirectory}/Downloads/archlinux-2024.10.01-x86_64.iso \
            # -drive if=pflash,format=raw,readonly=on,file=/nix/store/18fwgvs3k4mkp8i8j53clr83787dfqwp-OVMF-202408-fd/FV/OVMF_CODE.fd \
            # -drive if=pflash,format=raw,file=${config.home.homeDirectory}/.local/share/qemu-img/OVMF_VARS.fd \

            # -cdrom ${config.home.homeDirectory}/Downloads/archlinux-2024.10.01-x86_64.iso \
            # -drive file=${config.home.homeDirectory}/.local/share/qemu-img/image_file_1,format=qcow2
        ''}";
      };
    */
  };
}
