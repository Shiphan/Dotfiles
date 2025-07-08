{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      material-symbols
      nerd-fonts.noto
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Noto Serif CJK"
          "NotoSerif Nerd Font"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK"
          "NotoSans Nerd Font"
        ];
        monospace = [
	  "Noto Sans Mono"
	  "NotoSansM Nerd Font Mono"
	];
      };
    };
  };

  console = {
    keyMap = "us";
    font = "ter-v16n";
    packages = with pkgs; [
      terminus_font
    ];
    # useXkbConfig = true; # use xkb.options in tty.
  };
}
