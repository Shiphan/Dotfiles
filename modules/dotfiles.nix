{ config, ... }:

{
  xdg.enable = true;
  xdg.configFile =
  let
    mapFn = x: {
      name = x;
      value.source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/${x}";
    };
    files = x: builtins.listToAttrs (map mapFn x);
  in
    # TODO: add wezterm
    files [ "eww" "hypr" "kitty" "rofi" "snackdaemon" "dunst" ];
}
