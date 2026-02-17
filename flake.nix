{
    inputs = {
        nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
        flake-parts = {
            url = "github:hercules-ci/flake-parts";
            inputs.nixpkgs-lib.follows = "nixpkgs-lib";
        };
        import-tree.url = "github:vic/import-tree";
    };

    outputs = inputs: let
        bootstrap = inputs.flake-parts.lib.mkFlake {inherit inputs;} {
            imports = [
                ./options.nix
                ./lib/mkFlake.nix
                ./lib/mkImportTreeModule.nix
                ./lib/mkFlakeFromTree.nix
            ];
        };
    in
        bootstrap.lib.mkFlakeFromTree {
            inherit inputs;
            root = ./.;
        };
}
