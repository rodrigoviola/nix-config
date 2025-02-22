{
  config,
  pkgs,
  ...
}: {

  imports = [
    ../modules/darwin
  ];

  users.users.rodrigo = {
    name = "rodrigo";
    home = "/Users/rodrigo";
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "rodrigo";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.computerName = "MacBook-Pro-M1";
  networking.hostName = "MacBook-Pro-M1";
}
