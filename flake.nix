{
  description = "MacBook Pro M1 system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    nix-homebrew,
    home-manager,
  }: let
    configuration = {
      pkgs,
      config,
      ...
    }: {
      # Nix settings
      nix.settings.experimental-features = "nix-command flakes";
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;
      services.nix-daemon.enable = true;

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      homebrew = {
        enable = true;

        taps = [
          "cirruslabs/cli" # Tart
          "FelixKratz/formulae" # SketchyBar, Borders
          "hashicorp/tap"
          "nikitabobko/tap" # AeroSpace
        ];

        brews = [
          "aws-vault"
          "awscli"
          "bat"
          "borders"
          "cirruslabs/cli/tart"
          "cmatrix"
          "coreutils"
          "fastfetch"
          "gh"
          "git"
          "gnu-sed"
          "gnu-tar"
          "helm"
          "htop"
          "hugo"
          "jq"
          "k9s"
          "kubectx"
          "kubernetes-cli"
          "lazygit"
          "mpv"
          "pwgen"
          "telnet"
          "terraform"
          "tmux"
          "tmuxinator"
          "tree"
          "watch"
          "wget"
          "yq"
          "yt-dlp"
          #"aria2"
          #"borders"
          #"curl"
          #"eksctl"
          #"entr"
          #"eza"
          #"fd"
          #"fzf"
          #"gnupg"
          #"go"
          #"helmfile"
          #"krew"
          #"kustomize"
          #"lazydocker"
          #"libpq" # PostgreSQL CLI tooling
          #"mas"
          #"neofetch"
          #"neovim"
          #"nmap"
          #"node"
          #"oh-my-posh"
          #"p7zip"
          #"ripgrep"
          #"stow"
          #"tpm"
        ];

        casks = [
          "aerospace"
          "alfred"
          "battery"
          "chatgpt"
          "claude"
          "cloudflare-warp"
          "coconutbattery"
          "drawio"
          "font-ibm-plex"
          "ghostty"
          "google-chrome"
          "keepingyouawake"
          "keyboardcleantool"
          "libreoffice"
          "notion"
          "sparrow"
          "spotify"
          "telegram"
          "the-unarchiver"
          "visual-studio-code"
          "whatsapp"
          #"anydesk"
          #"balenaetcher"
          #"bettertouchtool" # Installing v3 manually due to old license -- https://folivora.ai/releases/btt3.552-1692.zip
          #"bisq"
          #"docker"
          #"firefox"
          #"focus"
          #"font-blex-mono-nerd-font" # Nerd font version of IBM Plex
          #"font-meslo-lg-nerd-font"
          #"iterm2"
          #"lens"
          #"mactex" # Used for cv.pdf, to be replaced with xu-cheng/latex-docker
          #"microsoft-onenote"
          #"microsoft-remote-desktop"
          #"podman-desktop"
          #"raspberry-pi-imager"
          #"rectangle"
          #"session-manager-plugin"
          #"utm"
          #"vmware-fusion"
        ];

        masApps = {
          "Dark Mode for Safari" = 1397180934;
          "Disk Speed Test" = 425264550;
          "Kindle" = 302584613;
          "MindNode" = 1289197285;
          "Tabs Switcher" = 1406718335;
          "Wipr" = 1320666476;
        };

        onActivation = {
          autoUpdate = false;
          cleanup = "zap";
        };
      };

      # Enable TouchID for sudo authentication
      security.pam.enableSudoTouchIdAuth = true;

      # Customize Safari
      system.defaults.CustomUserPreferences = {
        "com.apple.Safari" = {
          "AlwaysRestoreSessionAtLaunch" = true;
          "ExtensionsEnabled" = true;
          "SearchProviderShortName" = "DuckDuckGo";
          "ShowFullURLInSmartSearchField" = false;
          "ShowOverlayStatusBar" = true;
        };
      };

      # Customize Finder
      system.defaults.finder._FXShowPosixPathInTitle = false;
      system.defaults.finder.AppleShowAllExtensions = true;
      system.defaults.finder.AppleShowAllFiles = true;
      system.defaults.finder.FXEnableExtensionChangeWarning = false;
      system.defaults.finder.QuitMenuItem = true;
      system.defaults.finder.ShowStatusBar = true;
      system.defaults.finder.ShowPathbar = true;

      # Customize Dock
      system.defaults.dock.autohide = true;
      system.defaults.dock.autohide-delay = 500.0;
      system.defaults.dock.show-recents = false;
      system.defaults.dock.tilesize = 40;
      system.defaults.dock.persistent-others = [];
      system.defaults.dock.persistent-apps = [
        "/System/Applications/Launchpad.app"
      ];

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

      # Customize Keyboard
      system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
      system.defaults.NSGlobalDomain.KeyRepeat = 2;
      system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
      system.keyboard.enableKeyMapping = true;
      system.keyboard.swapLeftCtrlAndFn = true;

      # Customize OS
      networking.hostName = "MacBook-Pro";
      time.timeZone = "America/Asuncion";
      system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
      system.defaults.screencapture = {
        location = "~/Desktop/Screenshots";
      };
    };
  in {
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "rodrigo";
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
