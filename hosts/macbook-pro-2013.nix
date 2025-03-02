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
    enableRosetta = false;
    user = "rodrigo";
  };

  nixpkgs.hostPlatform = "x86_64-darwin";

  networking.computerName = "MacBook-Pro-2013";
  networking.hostName = "MacBook-Pro-2013";
}
