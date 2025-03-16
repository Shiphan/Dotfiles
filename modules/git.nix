{ ... }:

{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "140245703+Shiphan@users.noreply.github.com";
      userName = "Shiphan";
      signing = {
        format = "ssh";
        signByDefault = true;
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcPTuR3Pb/F7ZarEjHaeSi83Uyzqc/9sD10jvTZKaYB 140245703+Shiphan@users.noreply.github.com";
        # key = builtins.readFile (config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.ssh/id_ed25519");
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
