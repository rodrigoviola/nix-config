# modules/darwin/home-manager.nix - Home Manager configuration
{
  config,
  pkgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rodrigo = {
      home = {
        username = "rodrigo";
        homeDirectory = "/Users/rodrigo";
        stateVersion = "24.11";
      };

      programs.home-manager.enable = true;
    };
  };
}
