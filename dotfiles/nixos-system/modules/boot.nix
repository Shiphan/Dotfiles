{ ... }:

{
  boot.loader = {
    # NOTE: on my framework 13, for showing grub menu, instead of holding shift key, you should spam esc
    timeout = 0;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      default = "saved";
      # theme = "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
      timeoutStyle = "countdown";
      extraEntries = ''
        if [ ''${grub_platform} == "efi" ]; then
          menuentry "UEFI Firmware Settings" --id "uefi-firmware" {
            fwsetup
          }
        fi
      '';
    };
  };
}
