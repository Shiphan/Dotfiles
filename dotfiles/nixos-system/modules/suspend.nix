{ ... }:

{
  swapDevices = [
    {
      device = "/swapfile";
      size = 16*1024;
    }
  ];

  boot = {
    resumeDevice = "/dev/nvme0n1p6";
    kernelParams = [
      "resume_offset=14116864"
    ];
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowSuspendThenHibernate=yes
    HibernateDelaySec=30min
  '';
}
