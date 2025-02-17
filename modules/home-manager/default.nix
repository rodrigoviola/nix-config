# modules/home-manager/default.nix
{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "rodrigo";
    homeDirectory = "/Users/rodrigo";
    stateVersion = "24.11";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Your home-manager configurations go here
  # programs.git.enable = true;
  # etc...
}
