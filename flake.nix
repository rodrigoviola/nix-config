{
  description = "MacBook system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, config, ... }: {

        nixpkgs.config.allowUnfree = true;

        homebrew = {
          enable = true;

          taps = [
            "hashicorp/tap"
            "nikitabobko/tap"
            "FelixKratz/formulae"
          ];

          brews = [
            "aws-vault"
            "awscli"
            "bat"
            "cmatrix"
            "fastfetch"
            "gh"
            "git"
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
            "yq"
            "yt-dlp"
            #"aria2"
            #"borders"
            #"coreutils"
            #"curl"
            #"eksctl"
            #"entr"
            #"eza"
            #"fd"
            #"fzf"
            #"gnu-sed"
            #"gnu-tar"
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
            #"wget"
          ];

          casks = [
            "aerospace"
            "alfred"
            "battery"
            "chatgpt"
            "claude"
            "coconutbattery"
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
            #"bettertouchtool"  # Installing v3 manually due to old license -- https://folivora.ai/releases/btt3.552-1692.zip
            #"bisq"
            #"cloudflare-warp"
            #"docker"
            #"drawio"
            #"firefox"
            #"focus"
            #"font-blex-mono-nerd-font" # Nerd font version of IBM Plex
            #"font-meslo-lg-nerd-font"
            #"iterm2"
            #"lens"
            #"mactex" Used for cv.pdf, to be replaced with xu-cheng/latex-docker
            #"microsoft-onenote"
            #"microsoft-remote-desktop"
            #"raspberry-pi-imager"
            #"rectangle"
            #"session-manager-plugin"
            #"utm"
            #"vmware-fusion"
          ];

           masApps = {
             "Dark Mode for Safari" = 1397180934;
             "Disk Speed Test" = 425264550;
             #"Kindle" = 302584613;
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

        # Customize Menu Bar
        # Reduce spacing to fit more items in MBP screen
        # defaults -currentHost write -globalDomain NSStatusItemSpacing -int 7 # Ref: https://www.reddit.com/r/MacOS/comments/1dfu8w0/psa_reduce_your_menu_bar_spacing_to_fit_more_items/

        # Customize Dock
        system.defaults.dock.autohide = true;
        system.defaults.dock.autohide-delay = 500.0; # Hide Dock indefinitely
        #system.defaults.dock.autohide = false;
        system.defaults.dock.show-recents = false; # Disable recent apps

        # Customize Keyboard
        system.defaults.NSGlobalDomain.InitialKeyRepeat = 15; # "Delay until repeat" == Short
        system.defaults.NSGlobalDomain.KeyRepeat = 2; # "Key repeat rate" == Fast
        system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false; # https://macos-defaults.com/keyboard/applepressandholdenabled.html
        system.keyboard.enableKeyMapping = true;
        system.keyboard.swapLeftCtrlAndFn = true;

        # Customize OS
        time.timeZone = "America/Asuncion";

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
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
