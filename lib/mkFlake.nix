{inputs, ...}: let
    inherit (inputs.flake-parts.lib) mkFlake;
in {
    flake.lib.mkFlake = {
        inputs,
        module,
        args ? {},
    }:
        mkFlake ({inherit inputs;} // args) module;
}
