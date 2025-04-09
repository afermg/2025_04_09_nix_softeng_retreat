{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs_master.url = "github:NixOS/nixpkgs/master";
    systems.url = "github:nix-systems/default";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
  };

  outputs = { self, nixpkgs, flake-utils, systems, ... } @ inputs:
      flake-utils.lib.eachDefaultSystem (system:
        let
            pkgs = import nixpkgs {
              system = system;
              config.allowUnfree = true;
            };

            libList = [
              ];
          in
          with pkgs;
        {
          devShells = {
            default  = let
              # These packages get built by Nix, and will be ahead on the PATH
            in mkShell {
              packages = [
                emacs
                texliveMedium
                ]
                ++ libList;
                shellHook = ''
                '';
             };
          };
        }
      );
}
