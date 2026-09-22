{
  description = "yala — Yet Another LLM Agent, written in Amber and compiled to Bash";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: rec {
        yala = pkgs.callPackage ./nix/package.nix { src = self; };
        default = yala;
      });

      checks = forAllSystems (pkgs: {
        inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) yala;
      });

      # `nixpkgs.overlays = [ inputs.yala.overlays.default ];` makes
      # `pkgs.yala` available in a NixOS / home-manager configuration.
      overlays.default = final: prev: {
        yala = final.callPackage ./nix/package.nix { src = self; };
      };

      # Minimal NixOS module: importing it installs yala system-wide.
      nixosModules.default =
        { pkgs, ... }:
        {
          environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.default ];
        };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
