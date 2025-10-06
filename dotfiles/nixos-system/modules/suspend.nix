{ ... }:

{
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowSuspendThenHibernate=yes
    HibernateDelaySec=30min
  '';

  services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
}
