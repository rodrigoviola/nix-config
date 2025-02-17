# modules/darwin/home-manager.nix - Home Manager configuration
{
  config,
  pkgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rodrigo = import ../home-manager;
  };
}
