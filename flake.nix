{
  description = "NixOS flake for BudsLink - Battery status and ANC control for Bluetooth earbuds";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      lib = nixpkgs.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: lib.genAttrs systems (system: f system);
      pkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      packages = forAllSystems (system:
        let pkgs = pkgsFor system; in {
          budslink = pkgs.callPackage ./pkgs/budslink.nix { };
          default = self.packages.${system}.budslink;
        });

      overlays.default = final: prev: {
        budslink = final.callPackage ./pkgs/budslink.nix { };
      };

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/budslink";
        };
      });

      nixosModules.default = { pkgs, ... }: {
        nixpkgs.overlays = [ self.overlays.default ];
        environment.systemPackages = [ pkgs.budslink ];
      };

      homeModules.default = { pkgs, ... }: {
        nixpkgs.overlays = [ self.overlays.default ];
        home.packages = [ pkgs.budslink ];
      };
    };
}
