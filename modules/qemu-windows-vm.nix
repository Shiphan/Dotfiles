{ config, pkgs, ... }:

let
  script = imageDir: ''
    mkdir -p "${imageDir}/tpmstate"
    "${pkgs.swtpm}/bin/swtpm" socket --tpm2 \
      --tpmstate dir="${imageDir}/tpmstate" \
      --ctrl type=unixio,path="${imageDir}/swtpm-sock" \
      &
    SWTPM_PID=$!

    "${pkgs.qemu}/bin/qemu-system-x86_64" \
      -monitor stdio \
      -enable-kvm \
      -cpu host,topoext=on,kvm=off,-hypervisor \
      -smp 8,sockets=1,cores=4,threads=2,maxcpus=8 \
      -vga virtio \
      -m 12G \
      -machine q35 \
      -usb -device usb-tablet \
      -audio pipewire,model=hda \
      -nic user,model=virtio-net-pci \
      -rtc base=localtime \
      -smbios type=0,vendor="$(cat /sys/class/dmi/id/bios_vendor)",version="$(cat /sys/class/dmi/id/bios_version)",date="$(cat /sys/class/dmi/id/bios_date)",release="$(cat /sys/class/dmi/id/bios_release)" \
      -smbios type=1,manufacturer="$(cat /sys/class/dmi/id/sys_vendor)",product="$(cat /sys/class/dmi/id/product_name)",version="$(cat /sys/class/dmi/id/product_version)" \
      -boot order=dc,menu=on \
      -drive file="${pkgs.OVMFFull.fd}/FV/OVMF_CODE.fd",format=raw,readonly=on,if=pflash \
      -drive file="${imageDir}/OVMF_VARS.ms.fd",format=raw,if=pflash \
      -chardev socket,id=chrtpm,path="${imageDir}/swtpm-sock" \
      -tpmdev emulator,id=tpm0,chardev=chrtpm \
      -device tpm-tis,tpmdev=tpm0 \
      -drive file="${imageDir}/image_file.img",if=virtio

    echo "Waiting for swtpm to exit..."
    wait $SWTPM_PID
  '';
in
{
  home.packages = with pkgs; [
    qemu
    OVMFFull.fd
    swtpm
  ];
  xdg.desktopEntries = {
    "windows-10" = {
      name = "Windows 10";
      icon = "qemu";
      terminal = true;
      exec = "${pkgs.writeShellScript "qemu-windows-10" (
        script "${config.xdg.dataHome}/qemu-img/windows-10"
      )}";
    };
    "windows-11" = {
      name = "Windows 11";
      icon = "qemu";
      terminal = true;
      exec =
        let
          # INFO: before connect windows 11 vm to internet, you can still use personalization
          script = imageDir: ''
            mkdir -p "${imageDir}/tpmstate"
            "${pkgs.swtpm}/bin/swtpm" socket --tpm2 \
              --tpmstate dir="${imageDir}/tpmstate" \
              --ctrl type=unixio,path="${imageDir}/swtpm-sock" \
              &
            SWTPM_PID=$!

            "${pkgs.qemu}/bin/qemu-system-x86_64" \
              -monitor stdio \
              -enable-kvm \
              -cpu host,topoext=on,kvm=off,-hypervisor \
              -smp 8,sockets=1,cores=4,threads=2,maxcpus=8 \
              -vga virtio \
              -m 12G \
              -machine q35 \
              -usb -device usb-tablet \
              -audio pipewire,model=hda \
              -nic none \
              -rtc base=localtime \
              -smbios type=0,vendor="$(cat /sys/class/dmi/id/bios_vendor)",version="$(cat /sys/class/dmi/id/bios_version)",date="$(cat /sys/class/dmi/id/bios_date)",release="$(cat /sys/class/dmi/id/bios_release)" \
              -smbios type=1,manufacturer="$(cat /sys/class/dmi/id/sys_vendor)",product="$(cat /sys/class/dmi/id/product_name)",version="$(cat /sys/class/dmi/id/product_version)" \
              -boot order=dc,menu=on \
              -drive file="${pkgs.OVMFFull.fd}/FV/OVMF_CODE.fd",format=raw,readonly=on,if=pflash \
              -drive file="${imageDir}/OVMF_VARS.ms.fd",format=raw,if=pflash \
              -chardev socket,id=chrtpm,path="${imageDir}/swtpm-sock" \
              -tpmdev emulator,id=tpm0,chardev=chrtpm \
              -device tpm-tis,tpmdev=tpm0 \
              -drive file="${imageDir}/image_file.img",if=ide

              # -nic user,model=virtio-net-pci \
              # -drive file="${imageDir}/image_file.img",if=virtio

            echo "Waiting for swtpm to exit..."
            wait $SWTPM_PID
          '';
        in
        "${pkgs.writeShellScript "qemu-windows-11" (script "${config.xdg.dataHome}/qemu-img/windows-11")}";
    };
  };
}
