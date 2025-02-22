# modules/darwin/system.nix - System preferences and defaults
{
  config,
  pkgs,
  ...
}: {
  #users.users.rodrigo = {
  #  name = "rodrigo";
  #  home = "/Users/rodrigo";
  #};

  # Enable TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Customize OS
  time.timeZone = "America/Asuncion";
  system.defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 0;
  system.defaults.NSGlobalDomain."com.apple.sound.beep.volume" = 0.0;
  system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
  system.defaults.loginwindow.GuestEnabled = false;
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  system.defaults.screencapture = {
    location = "~/Desktop/Screenshots";
  };
}
