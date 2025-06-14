# modules/darwin/homebrew.nix - Homebrew configuration
{
  config,
  pkgs,
  ...
}: let
  isAarch64 = pkgs.stdenv.system == "aarch64-darwin";
  isX86_64 = pkgs.stdenv.system == "x86_64-darwin";
in {
  homebrew = {
    enable = true;

    taps = [
      "cirruslabs/cli" # Tart
      #"FelixKratz/formulae" # SketchyBar, JankyBorders
      "hashicorp/tap"
      "nikitabobko/tap" # AeroSpace
    ];

    brews = [
      "7-zip"
      "atuin"
      "aws-vault"
      "awscli"
      "bat"
      "btop"
      "cirruslabs/cli/tart"
      "cmatrix"
      "colima"
      "coreutils"
      "eksctl"
      "fastfetch"
      "gh"
      "git"
      "gnu-sed"
      "gnu-tar"
      "gnupg"
      "go"
      "gomplate"
      "hashicorp/tap/packer"
      "hashicorp/tap/terraform"
      "helm"
      "htop"
      "hugo"
      "ipmitool"
      "jq"
      "k9s"
      "kubectx"
      "kubernetes-cli"
      "lazygit"
      "mas"
      "minikube"
      "mpv"
      "neovim"
      "nmap"
      "npm"
      "podman-compose"
      "podman"
      "pwgen"
      "telnet"
      "terraform-docs"
      "tmux"
      "tmuxinator"
      "tree"
      "watch"
      "wget"
      "yq"
      "yt-dlp"
      #"aria2"
      #"borders"
      #"entr"
      #"eza"
      #"fd"
      #"fzf"
      #"helmfile"
      #"krew"
      #"kustomize"
      #"lazydocker"
      #"node"
      #"oh-my-posh"
      #"ripgrep"
      #"stow"
      #"tpm"
    ];

    casks =
      [
        "aerospace"
        "anydesk"
        "alfred"
        "balenaetcher"
      ]
      ++ (
        if isAarch64
        then [
          "battery"
          "chatgpt"
        ]
        else []
      )
      ++ [
        "claude"
        "cloudflare-warp"
        "coconutbattery"
        "cursor"
        "drawio"
        "font-ibm-plex"
        "google-chrome"
        "iterm2"
        "keepingyouawake"
        "keyboardcleantool"
        "libreoffice"
        "notion"
        "raspberry-pi-imager"
        "rectangle"
        "session-manager-plugin" # Plugin for AWS CLI to start and end sessions that connect to managed instances
        "sparrow"
        "spotify"
        "telegram"
        "trezor-suite"
        "the-unarchiver"
        "visual-studio-code"
        "whatsapp"
        #"bettertouchtool" # Installing v3 manually due to old license -- https://folivora.ai/releases/btt3.552-1692.zip
        #"bisq"
        #"docker"
        #"firefox"
        #"focus"
        #"ghostty"
        #"lens"
        #"mactex" # Used for cv.pdf, to be replaced with xu-cheng/latex-docker
        #"microsoft-onenote"
        #"microsoft-remote-desktop"
        #"podman-desktop"
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
}
