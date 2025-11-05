# DW-Proton for Nix

A Nix flake that packages the latest [DW-Proton](https://dawn.wine/) compatibility layer for Steam Play.

## Features

- Automatically tracks the latest DW-Proton releases
- Daily GitHub Actions workflow to check for updates
- Simple flake-based installation

## Usage

### With Nix Flakes

```bash
# Test the package
nix run github:Momoyaan/dwproton-flake

# Install to your profile
nix profile install github:Momoyaan/dwproton-flake
```

### NixOS Configuration

Add to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    cachy-proton.url = "github:Momoyaan/dwproton-flake";
  };

  outputs = { self, nixpkgs, cachy-proton, ... }: {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
     ...

    };
  };
}
```

## Development

```bash
# Enter development shell
nix develop

# Build the package
nix build
```

## Updates

This flake automatically checks for new DW-Proton releases daily and creates pull requests when updates are available.

## License

This packaging is provided under the MIT license. DW-Proton itself may contain proprietary components.
