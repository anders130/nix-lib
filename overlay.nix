{config, ...}: {
    flake.overlays.default = final: _:
        builtins.mapAttrs (_: fn: final.callPackage fn {}) config.packageDefs;
}
