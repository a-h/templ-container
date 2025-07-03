{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    templ.url = "github:a-h/templ/v0.3.906";
  };

  outputs = { self, nixpkgs, templ }:
    let
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        system = system;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              templ = templ.outputs.packages.${system}.templ;
            })
          ];
        };
      });

      devTools = pkgs: [
        pkgs.go
        pkgs.templ
      ];
    in
    {
      devShells = forAllSystems ({ system, pkgs }: {
        default = pkgs.mkShell {
          buildInputs = (devTools pkgs);
        };
      });
    };
}
