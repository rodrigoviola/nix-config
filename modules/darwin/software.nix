# modules/darwin/software.nix - Custom software preferences
{
  config,
  pkgs,
  ...
}: {
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
  };
}
