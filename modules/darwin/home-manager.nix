# modules/darwin/home-manager.nix - Home Manager configuration
{
  config,
  pkgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rodrigo = {
      home = {
        username = "rodrigo";
        homeDirectory = "/Users/rodrigo";
        stateVersion = "24.11";

        file.".aerospace.toml".source = ../../dotfiles/aerospace/.aerospace.toml;
        file.".config/ghostty/config".source = ../../dotfiles/ghostty/config;
        file.".gitconfig-itti".source = ../../dotfiles/git/.gitconfig-itti;
        file.".gitconfig-rvo".source = ../../dotfiles/git/.gitconfig-rvo;
        file.".gitconfig".source = ../../dotfiles/git/.gitconfig;
        file.".ssh/config".source = ../../dotfiles/ssh/config;
        file.".tmux.conf".source = ../../dotfiles/tmux/tmux.conf;
        file.".vimrc".source = ../../dotfiles/vim/.vimrc;
      };

      programs.home-manager.enable = true;
    };
  };
}
