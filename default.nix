{ sources ? import ./nix/sources.nix,
  nixpkgs ? sources.nixpkgs }:
let
  nixos = import "${toString nixpkgs}/nixos" {
    configuration = import ./configuration.nix;
  };
in
{
  legacy = nixos.config.system.build.raw;
}

