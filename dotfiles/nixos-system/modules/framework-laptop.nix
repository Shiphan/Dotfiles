{ pkgs, ... }:

{
  services = {
    fwupd.enable = true;
    fprintd.enable = true;
    power-profiles-daemon.enable = true;
  };
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    sensor.iio.enable = true;
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd # OpenCL
        # amdvlk
      ];
    };
  };
}
