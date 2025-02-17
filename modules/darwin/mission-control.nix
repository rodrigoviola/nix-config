# modules/darwin/mission-control.nix - Mission Control preferences
{
  config,
  pkgs,
  ...
}: {
  system.defaults.dock.expose-group-apps = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.spaces.spans-displays = true;
}
