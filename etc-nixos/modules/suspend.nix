{ ... }:

{
  systemd.sleep.settings.Sleep = {
    AllowSuspend = true;
    AllowHibernation = true;
    AllowSuspendThenHibernate = true;
    HibernateDelaySec = "30min";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
  };
}
