{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "shiphan" = {
      description = "Shiphan";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
      # packages = with pkgs; [ ];
      shell = pkgs.zsh;
    };
  };
}
