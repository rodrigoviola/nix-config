# modules/darwin/networking.nix - Networking preferences
{
  config,
  pkgs,
  ...
}: {
  #networking.computerName = "MacBook-Pro";
  #networking.hostName = "MacBook-Pro";
  networking.dns = ["8.8.8.8" "8.8.4.4"];
  networking.knownNetworkServices = ["Wi-Fi"];

  # Customize Firewall
  # Taken from https://github.com/LnL7/nix-darwin/issues/1243#issuecomment-2605697835
  system.activationScripts.postUserActivation.text = ''
    # Configure firewall
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp on
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
  '';
}
