{
  description = "MacBook Pro M1 system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
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
  }: {
    darwinConfigurations = {
      # MacBook Pro M1 configuration
      "mbp" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/macbook-pro-m1.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
        ];
      };

      # MacBook Pro 2013 configuration
      "mbp-2013" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/macbook-pro-2013.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
        ];
      };

      # macOS VM configuration
      "vm" = nix-darwin.lib.darwinSystem {
        modules = [
          ./vms/macos-vm.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
        ];
      };
    };

    # Expose the package sets for both configurations
    darwinPackages = {
      mbp = self.darwinConfigurations."mbp".pkgs;
      mbp-2013 = self.darwinConfigurations."mbp-2013".pkgs;
      vm = self.darwinConfigurations."vm".pkgs;
    };
  };
}
