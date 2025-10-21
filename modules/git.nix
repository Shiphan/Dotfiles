{ ... }:

{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      signing = {
        format = "ssh";
        signByDefault = true;
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcPTuR3Pb/F7ZarEjHaeSi83Uyzqc/9sD10jvTZKaYB 140245703+Shiphan@users.noreply.github.com";
        # key = builtins.readFile (config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.ssh/id_ed25519");
      };
      settings = {
        user = {
          email = "140245703+Shiphan@users.noreply.github.com";
          name = "Shiphan";
        };
        extraConfig = {
          init.defaultBranch = "main";
          merge.tool = "nvimdiff";
        };
      };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
