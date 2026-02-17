{lib, ...}: let
    inherit (lib) mkDefault mkOption types;
in {
    options = {
        flake.lib = mkOption {
            type = types.lazyAttrsOf types.raw;
            default = {};
        };
        packageDefs = mkOption {
            type = types.lazyAttrsOf types.raw;
            default = {};
        };
    };
    config.systems = mkDefault [];
}
