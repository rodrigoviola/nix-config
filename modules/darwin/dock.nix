# modules/darwin/dock.nix - Dock preferences
{
  config,
  pkgs,
  ...
}: {
  system.defaults.dock = {
    autohide = true;
    autohide-delay = 500.0;
    show-recents = false;
    tilesize = 40;
    persistent-others = [];
    persistent-apps = [
      "/System/Applications/Launchpad.app"
    ];
  };
}
