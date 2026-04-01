{
  description = "Empty Flake";
  inputs = {
    system-flake.url = "path:/etc/nixos";
    nixpkgs.follows = "system-flake/nixpkgs";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "Compiler Flake";

        buildInputs = with pkgs; [
          bison
          flex
        ];

        shellHook = "";
      };
    };
}
