{
    packageDefs.alejandra-with-config = {
        alejandra,
        makeWrapper,
        symlinkJoin,
        writers,
        settings ? {
            indentation = "FourSpaces";
        },
    }: let
        configFile = writers.writeTOML "alejandra.toml" settings;
    in
        symlinkJoin {
            name = "alejandra-with-config-${alejandra.version}";
            paths = [alejandra];
            nativeBuildInputs = [makeWrapper];
            postBuild = ''
                wrapProgram $out/bin/alejandra \
                    --add-flags "--experimental-config ${configFile}"
            '';
            meta.mainProgram = "alejandra";
        };
}
