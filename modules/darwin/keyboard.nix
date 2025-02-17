# modules/darwin/keyboard.nix - Keyboard preferences
{
  config,
  pkgs,
  ...
}: {
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";
  system.keyboard.enableKeyMapping = true;
  system.keyboard.swapLeftCtrlAndFn = true;
}
