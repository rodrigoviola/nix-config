# modules/darwin/default.nix - Main system configuration
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./dock.nix
    ./finder.nix
    ./homebrew.nix
    #./home-manager.nix
    ./keyboard.nix
    ./mission-control.nix
    ./networking.nix
    ./software.nix
    ./system.nix
    ./trackpad.nix
  ];

  # Core system settings that don't fit elsewhere
  nix.settings.experimental-features = "nix-command flakes";
  #nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
