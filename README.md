```sh
# How to apply config after macOS reinstall

# Install dependencies
xcode-select --install

# Install Nix package manager
sh <(curl -L https://nixos.org/nix/install)

# Install nix-darwin
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake '.#mbp'

# Rebuild config
darwin-rebuild switch --flake '.#mbp'

# Utils
nix flake metadata
nix flake show
nix flake update
```
