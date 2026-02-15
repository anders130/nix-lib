{
    coreutils,
    fish,
    installShellFiles,
    lib,
    makeWrapper,
    stdenv,
}: {
    name,
    script,
    version ? "0.1.0",
    runtimeInputs ? [],
    completions ? null,
    meta ? {},
}: let
    defaultRuntimeInputs = [
        coreutils
        fish
    ];
in
    stdenv.mkDerivation {
        pname = name;
        inherit version;

        src = null;
        dontUnpack = true;

        nativeBuildInputs =
            [makeWrapper]
            ++ lib.optional (completions != null) installShellFiles;

        installPhase =
            ''
                mkdir -p $out/bin
                cp ${script} $out/bin/${name}
                chmod +x $out/bin/${name}
                wrapProgram $out/bin/${name} \
                    --prefix PATH : ${lib.makeBinPath (defaultRuntimeInputs ++ runtimeInputs)}
            ''
            + lib.optionalString (completions != null) ''
                installShellCompletion --cmd ${name} --fish ${completions}
            '';

        inherit meta;
    }
