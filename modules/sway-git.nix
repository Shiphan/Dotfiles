{ pkgs, ... }:

let
  wlroots = pkgs.wlroots.overrideAttrs (_: rec {
    version = "0.19.0-rc3";

    src = pkgs.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = version;
      hash = "sha256-ZqchXPR/yfkAGwiY9oigif0Ef4OijHcGPGUXfHaL5v8=";
    };
  });
  sway-unwrapped =
    (pkgs.sway-unwrapped.overrideAttrs (_: rec {
      version = "1.11-rc2";

      src = pkgs.fetchFromGitHub {
        owner = "swaywm";
        repo = "sway";
        rev = version;
        hash = "sha256-WsAUZqeOlSHO8vMhAqwqb/DqE82MCSz0CJCDBCWbU9g=";
      };
    })).override
      (_: {
        inherit wlroots;
      });
in
{
  home.packages = with pkgs; [
    (sway.override (_: {
      inherit sway-unwrapped;
    }))
  ];
}
