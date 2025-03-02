{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Asuncion";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  networking.hostName = "supermicro";
  networking.firewall.enable = false;
  networking.nameservers = ["1.1.1.1" "8.8.8.8"];
  networking.interfaces.eno1 = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "192.168.100.251";
        prefixLength = 24;
      }
    ];
    ipv4.routes = [
      {
        address = "0.0.0.0";
        prefixLength = 0;
        via = "192.168.100.1";
      }
    ];
  };

  services.timesyncd.enable = true;
  services.fstrim.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = ["rodrigo"];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  programs.zsh.enable = true;

  users.users.rodrigo = {
    isNormalUser = true;
    description = "Rodrigo";
    home = "/home/rodrigo";
    shell = pkgs.zsh;
    extraGroups = ["wheel" "network"];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJiW3HALVTNgZht7LprdBUusZLqvDu+p5dE/dogjP/wuUjcOuE7NUfP3mv2AZ3C9llT/PCaLv35J4y6vHNIiNCU2TEmFuwTyVQryyHbW2SNXM7m5DPkNxXKBvS4X7B87uYWhgLQQ6CgRHrm9M6pC0YfDlGIZi8ADgnkepZD9w2SXTY1CGuvMDJ8tT3hF6ZITW/rblyMrNRLScgPR9QeWIWTZkv/bePsKxn4MOqbFspj/0TcWVFuA6WDzSthEGrxi8YgKfGgpuMfHNpsi+gdzS3upRjgxvgCHYv2oQvSO4Vh1p/2jyyf5YexwQt4vQKcl//GcGoS4Oyk58m6tPGNxk9S7hGE/i5pNEoRm27ON3Ff1Vw5KCCSl91Z7otMg+XdFn7xLzkej0O7WtMj0DMUnvGK7+6A4CZ+qrM0RJjlCdv8Yl0cPCyrtfiPktv/y93lf5SadF7YO2RroHgW3FradaLA6MUUGDwQHRnzt7/SZe20PTZKMNK7GzOg0ik7wyDjEux5/R2mnk6VBO+fJazy3iMsuHAnSavtlkoq1A3gxej1NiT9qS32RXZNan/UfOnM738WCFzAM+yWMCNRatFYVhIg1unYa/9VrYmnEpAy9Euh87xIfXt4YH9pmpk0NtL3M9Zea6vks8GSxead1ZlcSewqopQkN3VsWny08CHffskRQ== rodrigoviola@gmail.com"
    ];
  };

  environment.systemPackages = with pkgs; [
    alejandra
    bat
    btop
    cmatrix
    fastfetch
    file
    gh
    git
    jq
    lazygit
    tmux
    tree
    ncdu
    neovim
    wget
    zsh
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
