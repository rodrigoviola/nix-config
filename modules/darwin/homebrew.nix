# modules/darwin/homebrew.nix - Homebrew configuration
{
  config,
  pkgs,
  ...
}: {
  #nix-homebrew = {
  #  enable = true;
  #  enableRosetta = true;
  #  user = "rodrigo";
  #};

  homebrew = {
    enable = true;

    taps = [
      "cirruslabs/cli" # Tart
      "FelixKratz/formulae" # SketchyBar, JankyBorders
      "hashicorp/tap"
      "nikitabobko/tap" # AeroSpace
    ];

    brews = [
      "aws-vault"
      "awscli"
      "bat"
      "borders"
      "btop"
      "cirruslabs/cli/tart"
      "cmatrix"
      "coreutils"
      "fastfetch"
      "gh"
      "git"
      "gnu-sed"
      "gnu-tar"
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
      "mpv"
      "neovim"
      "podman"
      "pwgen"
      "telnet"
      "tmux"
      "tmuxinator"
      "tree"
      "watch"
      "wget"
      "yq"
      "yt-dlp"
      #"aria2"
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
      #"mas"
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
      "balenaetcher"
      "battery"
      "chatgpt"
      "claude"
      "cloudflare-warp"
      "coconutbattery"
      "drawio"
      "font-ibm-plex"
      "google-chrome"
      "iterm2"
      "keepingyouawake"
      "keyboardcleantool"
      "libreoffice"
      "notion"
      "rectangle"
      "session-manager-plugin" # Plugin for AWS CLI to start and end sessions that connect to managed instances
      "sparrow"
      "spotify"
      "telegram"
      "the-unarchiver"
      "visual-studio-code"
      "whatsapp"
      #"anydesk"
      #"bettertouchtool" # Installing v3 manually due to old license -- https://folivora.ai/releases/btt3.552-1692.zip
      #"bisq"
      #"docker"
      #"firefox"
      #"focus"
      #"font-blex-mono-nerd-font" # Nerd font version of IBM Plex
      #"font-meslo-lg-nerd-font"
      #"ghostty"
      #"lens"
      #"mactex" # Used for cv.pdf, to be replaced with xu-cheng/latex-docker
      #"microsoft-onenote"
      #"microsoft-remote-desktop"
      #"podman-desktop"
      #"raspberry-pi-imager"
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
