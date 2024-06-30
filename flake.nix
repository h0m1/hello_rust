{
  description = "Hello rust flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (system: let
      pkgs = (import nixpkgs {inherit system;}).pkgsStatic;
    in {
      hello-rust = pkgs.rustPlatform.buildRustPackage rec {
        pname = "hello-rust";
        version = "0.1.0";

        src = ./.;
        cargoLock = {
          lockFile = ./Cargo.lock;
        };

        doCheck = true;

        env = {};
      };
    });

    defaultPackage = forAllSystems (system: self.packages.${system}.hello-rust);

    defaultApp = forAllSystems (system: {
      type = "app";
      program = "${self.packages.${system}.hello-rust}/bin/hello";
    });

    devShell = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in
      pkgs.mkShell {
        buildInputs = with pkgs; [cargo rust-analyzer];
        shellHook = ''
          export CARGO_HOME=$(pwd)/cargo
        '';
      });
  };
}
