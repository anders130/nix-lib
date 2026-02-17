{
    inputs,
    lib,
    ...
}: {
    flake.lib.mkImportTreeModule = {
        root,
        ignore ? ["flake.nix"],
    }: let
        ignoreStep = name: t:
            t.filterNot (path: lib.hasSuffix ("/" + name) (toString path));

        steps =
            (map ignoreStep ignore)
            ++ [
                (t: t.filterNot (path: lib.hasInfix "/_" (toString path)))
                (t: t.addPath root)
                (t: t.result)
            ];
    in
        lib.pipe inputs.import-tree.new steps;
}
