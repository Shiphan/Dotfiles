{ pkgs, ... }:

let
  wlroots = pkgs.wlroots.overrideAttrs (_: {
    version = "unstable-2025-03-22";

    src = pkgs.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = "128cd07e9156a80dcd79178c3e669ddae2c71430";
      hash = "sha256-ecMWJGqzT2Qb6LViA884WxOInr7BeiEXPsR853d8mSs=";
    };
  });
  sway-unwrapped =
    (pkgs.sway-unwrapped.overrideAttrs (_: {
      version = "unstable-2025-03-22";

      src = pkgs.fetchFromGitHub {
        owner = "swaywm";
        repo = "sway";
        rev = "c2d6aff64c1e265c8f1d95b780b54193defae18a";
        hash = "sha256-A6QBjxmwrFmg6A7BHnKRNFMHoB8a6Q31hWvZj2KbV6c=";
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
