{
  description = "Xob Brightness Bar";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = let watcher = pkgs.callPackage ./derivation.nix { };
        in pkgs.writeShellScriptBin "brightness-bar" ''
          ${watcher}/bin/brightness-watcher.py | ${pkgs.xob}/bin/xob -c ${
            ./xob.config
          } -s default
        '';

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.python39
            pkgs.python39Packages.watchdog
            pkgs.xob
            pkgs.nixfmt
          ];
        };
      }) // {
        overlays.default = import ./overlay.nix;
      };
}
