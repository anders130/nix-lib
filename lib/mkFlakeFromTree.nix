{config, ...}: {
    flake.lib.mkFlakeFromTree = {
        inputs,
        root,
        ignore ? ["flake.nix"],
        args ? {},
    }:
        config.flake.lib.mkFlake {
            inherit inputs args;
            module = config.flake.lib.mkImportTreeModule {inherit root ignore;};
        };
}
