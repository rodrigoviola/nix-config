# modules/darwin/nix.nix - Nix configuration
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
  ];
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
