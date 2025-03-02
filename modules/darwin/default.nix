# modules/darwin/default.nix - Main system configuration
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./homebrew.nix
    #./home-manager.nix
    ./nix.nix
    ./system.nix
  ];
}
