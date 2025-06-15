{
  config,
  lib,
  pkgs,
  ...
}: {
  # ────────────────────────────────────────────────────────────────────────────────
  # Imports
  imports = [
    ./hardware-configuration.nix
  ];

  # ────────────────────────────────────────────────────────────────────────────────
  # Nix Settings
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # ────────────────────────────────────────────────────────────────────────────────
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821au # TP-Link Archer T2U PLUS [RTL8821AU]
  ];

  # ────────────────────────────────────────────────────────────────────────────────
  # Localization
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Asuncion";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # ────────────────────────────────────────────────────────────────────────────────
  # Swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 32768; # Size in MB (32 GB)
    }
  ];

  # ────────────────────────────────────────────────────────────────────────────────
  # Networking
  networking.hostName = "sys-e200-8d";
  networking.firewall.enable = false;
  networking.nameservers = ["1.1.1.1" "8.8.8.8"];
  networking.wireless.enable = true;
  networking.wireless.networks.darkstar.psk = builtins.readFile /etc/nixos/secrets/darkstar.psk;

  # networking.interfaces.eno1 = {
  #   useDHCP = false;
  #   ipv4.addresses = [
  #     {
  #       address = "192.168.100.251";
  #       prefixLength = 24;
  #     }
  #   ];
  #   ipv4.routes = [
  #     {
  #       address = "0.0.0.0";
  #       prefixLength = 0;
  #       via = "192.168.100.1";
  #     }
  #   ];
  # };

  networking.interfaces.wlp0s20u2 = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "192.168.100.252";
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

  # ────────────────────────────────────────────────────────────────────────────────
  # Services
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

  # ────────────────────────────────────────────────────────────────────────────────
  # Power Management
  powerManagement.cpuFreqGovernor = "ondemand";

  # ────────────────────────────────────────────────────────────────────────────────
  # Shell
  programs.zsh.enable = true;

  # ────────────────────────────────────────────────────────────────────────────────
  # Users
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

  # ────────────────────────────────────────────────────────────────────────────────
  # System Packages
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    btop
    cmatrix
    fastfetch
    file
    gh
    git
    ipmitool
    jq
    lazygit
    lm_sensors
    ncdu
    neovim
    tmux
    tree
    usbutils
    wget
    zsh
  ];

  # ────────────────────────────────────────────────────────────────────────────────
  # Miscellaneous
  # system.copySystemConfiguration = true;

  # ────────────────────────────────────────────────────────────────────────────────
  # System State Version
  system.stateVersion = "24.11";
}
