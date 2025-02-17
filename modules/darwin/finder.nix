# modules/darwin/finder.nix - Finder preferences
{
  config,
  pkgs,
  ...
}: {
  system.defaults.finder = {
    _FXShowPosixPathInTitle = false;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "Nlsv";
    NewWindowTarget = "Home";
    QuitMenuItem = true;
    ShowStatusBar = true;
    ShowPathbar = true;
  };
}
