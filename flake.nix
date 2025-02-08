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
            #"aria2"
            "aws-vault"
            "awscli"
            "bat"
            #"borders"
            "cmatrix"
            #"coreutils"
            #"curl"
            #"eksctl"
            #"entr"
            #"eza"
            "fastfetch"
            #"fd"
            #"fzf"
            "gh"
            "git"
            #"go"
            #"node"
            #"gnu-sed"
            #"gnu-tar"
            #"gnupg"
            "helm"
            #"helmfile"
            "htop"
            "hugo"
            "jq"
            "k9s"
            #"krew"
            "kubectx"
            "kubernetes-cli"
            #"kustomize"
            #"lazydocker"
            "lazygit"
            #"libpq" # PostgreSQL CLI tooling
            #"neofetch"
            #"neovim"
            #"nmap"
            "mpv"
            #"oh-my-posh"
            #"p7zip"
            "pwgen"
            #"ripgrep"
            #"stow"
            "telnet"
            "terraform"
            "tmux"
            #"tpm"
            "tree"
            "watch"
            #"wget"
            "yq"
            "yt-dlp"
            #"mas"
          ];

          casks = [
            "aerospace"
            "alfred"
            #"anydesk"
            #"balenaetcher"
            "battery"
            #"bettertouchtool"  # Installing v3 manually due to old license -- https://folivora.ai/releases/btt3.552-1692.zip
            #"bisq"
            "chatgpt"
            "claude"
            "coconutbattery"
            #"docker"
            #"drawio"
            #"firefox"
            #"focus"
            #"font-blex-mono-nerd-font" # Nerd font version of IBM Plex
            "font-ibm-plex"
            #"font-meslo-lg-nerd-font"
            "ghostty"
            "google-chrome"
            #"iterm2"
            "keepingyouawake"
            "keyboardcleantool"
            #"lens"
            "libreoffice"
            #"microsoft-onenote"
            #"microsoft-remote-desktop"
            "notion"
            #"raspberry-pi-imager"
            #"rectangle"
            #"session-manager-plugin"
            "sparrow"
            "spotify"
            "telegram"
            "the-unarchiver"
            #"utm"
            "visual-studio-code"
            #"vmware-fusion"
            "whatsapp"
            # "cloudflare-warp"
            # "mactex" Used for cv.pdf, to be replaced with xu-cheng/latex-docker
          ];

           masApps = {
             "Dark Mode for Safari" = 1397180934;
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
