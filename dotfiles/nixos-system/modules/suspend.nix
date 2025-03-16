{ ... }:

{
  swapDevices = [
    {
      device = "/swapfile";
      size = 28*1024;
    }
  ];

  boot = {
    resumeDevice = "/dev/nvme0n1p6";
    kernelParams = [
      "resume_offset=23891968"
    ];
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowSuspendThenHibernate=yes
    HibernateDelaySec=30min
  '';
}
