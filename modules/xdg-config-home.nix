{
  config,
  ...
}:

{
  xdg.enable = true;
  xdg.configFile =
    builtins.readDir ../xdg-config-home
    |> builtins.mapAttrs (
      name: _: {
        source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/xdg-config-home/${name}";
        target = name;
        recursive = false;
      }
    );
}
