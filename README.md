```sh
# How to apply config after macOS reinstall

# Install dependencies
xcode-select --install

# Install Nix package manager
sh <(curl -L https://nixos.org/nix/install)

# Install nix-darwin
sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake '.#mbp-m1'

# Rebuild config
sudo darwin-rebuild switch --flake '.#mbp-m1'

# Utils
nix flake metadata
nix flake show
nix flake update
```
