{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs {
          inherit system;
          config.contentAddressedByDefault = true;
        }; in
        {
          defaultPackage = (pkgs.callPackage ./Cargo.nix { }).rootCrate.build;
        }
      );
}
