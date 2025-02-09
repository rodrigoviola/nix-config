{
  description = "MacBook Pro M1 system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, config, ... }: {

        # Nix settings
        nixpkgs.config.allowUnfree = true;
        nix.settings.experimental-features = "nix-command flakes";
        services.nix-daemon.enable = true;

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";        

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
        # security.pam.enableSudoTouchIdAuth = true;

        # Customize Finder
        system.defaults.finder._FXShowPosixPathInTitle = false; # Show full path in Finder title
        system.defaults.finder.AppleShowAllExtensions = true; # Show all file extensions
        system.defaults.finder.FXEnableExtensionChangeWarning = false; # Disable warning when changing file extension
        system.defaults.finder.QuitMenuItem = true; # Enable quit menu item
        system.defaults.finder.ShowStatusBar = true;
        system.defaults.finder.ShowPathbar = true;

        # Customize Dock
        system.defaults.dock.autohide = true;
        system.defaults.dock.autohide-delay = 500.0; # Hide Dock indefinitely
        system.defaults.dock.show-recents = false; # Disable recent apps
        system.defaults.dock.tilesize = 40; # Icons size
        system.defaults.dock.persistent-apps = [
          "/System/Applications/Launchpad.app"
        ];

        # Customize Keyboard
        system.defaults.NSGlobalDomain.InitialKeyRepeat = 15; # "Delay until repeat" == Short
        system.defaults.NSGlobalDomain.KeyRepeat = 2; # "Key repeat rate" == Fast
        system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false; # https://macos-defaults.com/keyboard/applepressandholdenabled.html
        system.keyboard.enableKeyMapping = true;
        system.keyboard.swapLeftCtrlAndFn = true;

        # Customize OS
        networking.hostName = "MacBook-Pro";
        time.timeZone = "America/Asuncion";
      };
    in
    {
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
