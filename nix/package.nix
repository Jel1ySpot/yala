{
  lib,
  stdenv,
  amber-lang,
  bash,
  coreutils,
  curl,
  gnugrep,
  jq,
  makeWrapper,
  versionCheckHook,
  # Source tree to build. The flake passes its own source (`self`); a
  # nixpkgs-style caller would pass the release tarball:
  #   src = fetchFromGitHub { owner = "Jel1ySpot"; repo = "yala"; tag = "v${version}"; hash = "..."; };
  src,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "yala";

  # Keep in sync with `pub const VERSION` in src/cli.ab; the install check
  # fails when the two drift apart.
  version = "0.2.0";

  inherit src;

  nativeBuildInputs = [
    amber-lang
    makeWrapper
  ];

  # Compile the Amber sources into the standalone bash script.
  buildPhase = ''
    runHook preBuild
    amber build --target bash-4.3 src/main.ab yala.sh
    runHook postBuild
  '';

  doCheck = true;
  nativeCheckInputs = [
    bash
    coreutils
    gnugrep
    jq
  ];
  checkPhase = ''
    runHook preCheck
    amber test .
    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 yala.sh $out/bin/yala
    runHook postInstall
  '';

  # yala shells out to these; keep them in PATH so it never has to
  # bootstrap jq into /tmp/yala.
  postFixup = ''
    wrapProgram $out/bin/yala \
      --prefix PATH : ${
        lib.makeBinPath [
          bash
          coreutils
          curl
          gnugrep
          jq
        ]
      }
  '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;

  meta = {
    description = "Command-line LLM agent written in Amber and compiled to Bash";
    homepage = "https://github.com/Jel1ySpot/yala";
    changelog = "https://github.com/Jel1ySpot/yala/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    mainProgram = "yala";
    platforms = lib.platforms.unix;
  };
})
