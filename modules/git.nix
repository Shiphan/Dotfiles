{ ... }:

{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "140245703+Shiphan@users.noreply.github.com";
      userName = "Shiphan";
      # signing = { };
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
