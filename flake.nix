{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    mapPkgsForEachSystem = callback:
      nixpkgs.lib.genAttrs
      nixpkgs.lib.systems.flakeExposed
      (system: callback nixpkgs.legacyPackages.${system});
  in {
    devShells = mapPkgsForEachSystem (pkgs: {
      default = pkgs.mkShellNoCC {
        packages = with pkgs; [openjdk11 maven];
      };
    });
  };
}
