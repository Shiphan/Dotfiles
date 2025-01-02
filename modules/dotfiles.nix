{ ... }:

{
  home.file = {
    "eww" = {
      source = ../dotfiles/eww;
      target = ".config/eww";
    };
    "hypr" = {
      source = ../dotfiles/hypr;
      target = ".config/hypr";
    };
    "kitty" = {
      source = ../dotfiles/kitty;
      target = ".config/kitty";
    };
    "rofi" = {
      source = ../dotfiles/rofi;
      target = ".config/rofi";
    };
    "snackdaemon" = {
      source = ../dotfiles/snackdaemon;
      target = ".config/snackdaemon";
    };
  };
}
