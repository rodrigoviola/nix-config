# modules/darwin/trackpad.nix - Trackpad preferences
{
  config,
  pkgs,
  ...
}: {
  # Customize Trackpad
  # system.defaults.CustomUserPreferences = {
  #   "com.apple" = {
  #     "AppleMultitouchTrackpad.Dragging" = true;
  #     "AppleMultitouchTrackpad.TrackpadThreeFingerDrag" = true;
  #     "driver.AppleBluetoothMultitouch.trackpad.Dragging" = true;
  #     "driver.AppleBluetoothMultitouch.trackpad.TrackpadThreeFingerDrag" = true;
  #   };
  # };

  # TODO: these two options work but makes the trackpad buggy, not sure why
  #system.defaults.trackpad.TrackpadThreeFingerDrag = false;
  #system.defaults.trackpad.Dragging = false;

  #system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  #system.defaults.NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
  #system.defaults.NSGlobalDomain."com.apple.trackpad.forceClick" = true;
  #system.defaults.trackpad.TrackpadRightClick = true;
  #system.defaults.trackpad.Clicking = true;
}
