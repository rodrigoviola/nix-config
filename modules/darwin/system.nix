# modules/darwin/system.nix - System preferences and defaults
{
  config,
  pkgs,
  ...
}: let
  isM1 = config.networking.hostName == "MacBook-Pro-M1";
  is2013 = config.networking.hostName == "MacBook-Pro-2013";
in {
  ########################################
  ### Dock Configuration               ###
  ########################################
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

  ########################################
  ### Mission Control & Spaces         ###
  ########################################
  system.defaults.dock.expose-group-apps = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.spaces.spans-displays = false;

  ########################################
  ### Finder Preferences               ###
  ########################################
  system.defaults.finder = {
    _FXShowPosixPathInTitle = false;
    _FXSortFoldersFirst = true;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    FXDefaultSearchScope = "SCcf"; # When performing a search, search the current folder by default
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "Nlsv";
    NewWindowTarget = "Home";
    QuitMenuItem = true;
    ShowExternalHardDrivesOnDesktop = true;
    ShowHardDrivesOnDesktop = true;
    ShowMountedServersOnDesktop = true;
    ShowPathbar = true;
    ShowRemovableMediaOnDesktop = true;
    ShowStatusBar = true;
  };

  ########################################
  ### Keyboard Settings                ###
  ########################################
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";
  system.keyboard.enableKeyMapping = true;
  system.keyboard.swapLeftCtrlAndFn = true;

  ########################################
  ### Trackpad Configuration           ###
  ########################################
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 2.0;
  system.defaults.trackpad = {
    Clicking = true;
    TrackpadRightClick = true;
    TrackpadThreeFingerDrag = true;
    TrackpadThreeFingerTapGesture = 2;
  };

  ########################################
  ### System Preferences & Security    ###
  ########################################
  time.timeZone = "America/Asuncion";
  system.defaults.loginwindow.GuestEnabled = false;
  system.defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 0;
  system.defaults.NSGlobalDomain."com.apple.sound.beep.volume" = 0.0;
  system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  system.defaults.universalaccess.reduceMotion = true;
  system.defaults.universalaccess.reduceTransparency = is2013;
  system.defaults.screencapture = {
    location = "~/Desktop/Screenshots";
  };

  ########################################
  ### Networking Configuration         ###
  ########################################
  networking.dns = ["8.8.8.8" "8.8.4.4"];
  networking.knownNetworkServices = ["Wi-Fi"];

  ########################################
  ### System Activation                ###
  ########################################
  system.activationScripts.postUserActivation.text = ''
    # Configure firewall
    # Taken from https://github.com/LnL7/nix-darwin/issues/1243#issuecomment-2605697835
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp on
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`
    # activateSettings -u will reload the settings from the database and apply them to the current session,
    # so we do not need to logout and login again to make the changes take effect.
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  ########################################
  ### Custom Application Preferences   ###
  ########################################
  system.defaults.CustomUserPreferences = {
    # Customize Safari
    "com.apple.Safari" = {
      "AlwaysRestoreSessionAtLaunch" = true;
      "ExtensionsEnabled" = true;
      # FIXME: doesn't work
      # "IncludeInternalDebugMenu" = true;
      # "IncludeDevelopMenu" = true;
      # "WebKitDeveloperExtrasEnabledPreferenceKey" = true;
      # "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
      "SearchProviderShortName" = "DuckDuckGo";
      "ShowFullURLInSmartSearchField" = false;
      "ShowOverlayStatusBar" = true;
    };

    # Customize iTerm2
    "com.googlecode.iterm2" = {
      "AllowClipboardAccess" = true;
      "PromptOnQuit" = false;
      "HideTab" = true;
    };

    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };

    # Disable Dictation
    "com.apple.HIToolbox" = {
      AppleDictationAutoEnable = false;
    };
  };
}
