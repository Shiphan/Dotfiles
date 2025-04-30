{ ... }:

{
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowSuspendThenHibernate=yes
    HibernateDelaySec=30min
  '';

  services.logind.lidSwitch = "suspend-then-hibernate";
}
