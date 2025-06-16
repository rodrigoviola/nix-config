{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/darwin
  ];

  system.primaryUser = "admin";

  users.users.admin = {
    name = "admin";
    home = "/Users/admin";
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "admin";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.computerName = "macos-vm";
  networking.hostName = "macos-vm";
}
