{ config, lib, pkgs, ... }@args:

{
  home.packages = with pkgs; [
    /*
    firefox
    firefox-beta
    firefox-beta-unwrapped
    firefox-devedition
    firefox-devedition-unwrapped
    (runCommand "firefox-beta" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.firefox-beta}/bin/firefox-beta $out/bin/firefox-beta
      ln -s ${pkgs.firefox-beta}/share $out/share
    '')
    */
    (runCommand "firefox-devedition" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.firefox-devedition}/bin/firefox-devedition $out/bin/firefox-devedition
      ln -s ${pkgs.firefox-devedition}/share $out/share
    '')
    args.firefox.packages.${pkgs.system}.firefox-nightly-bin
  ];

  /*
  xdg.desktopEntries = {
    "firefox-nightly" = {
      name = "Firefox Nightly";
      exec = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/bin/firefox-nightly --name firefox-nightly %U";
      # icon = "firefox-nightly";
      icon = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin}/share/icons/hicolor/128x128/apps/firefox-nightly.png";
      # icon = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/share";
      categories = [ "Network" "WebBrowser" ];
      genericName = "Web Browser";
      type = "Application";
      mimeType = [ "text/html" "text/xml" "application/xhtml+xml" "application/vnd.mozilla.xul+xml" "x-scheme-handler/http" "x-scheme-handler/https" ];
      startupNotify = true;

      actions = {
        "new-private-window" = {
          name = "New Private Window";
          exec = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/bin/firefox-nightly --private-window %U";
        };
        "new-window" = {
          name= "New Window";
          exec = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/bin/firefox-nightly --new-window %U";
        };
        "profile-manager-window" = {
          name= "Profile Manager";
          exec= "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/bin/firefox-nightly --ProfileManager";
        };
      };
    };
  };
  */

  /*
  home.file = {
    "firefox-devedition-desktop-entry" = {
      source = "${pkgs.firefox-devedition}/share";
      target = ".local/share";
      recursive = true;
    };
    "firefox-beta-desktop-entry" = {
      source = "${pkgs.firefox-beta}";
      target = ".nix-profile/share";
      recursive = true;
    };
  } // (
  let
    recursive = a: lib.concatMapAttrs (_: value:
      if (builtins.readFileType value.source) == "directory" then
        recursive (builtins.mapAttrs (name: _: { source = "${value.source}/${name}"; target = "${value.target}/${name}"; }) (builtins.readDir value.source))
      else
        { ${value.target} = { source = value.source; }; }
      ) a;
  in
    recursive {
      "firefox-devedition-desktop-entry" = {
        source = "${pkgs.firefox-devedition}/share";
        target = ".local/share";
      };
    }
  );
  */
}
