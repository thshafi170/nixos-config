{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  pciutils,
  glibc,
}:

stdenv.mkDerivation {
  pname = "dgop";
  version = "0.0.6";

  src = fetchurl {
    url = "https://github.com/AvengeMedia/dgop/releases/download/v0.0.6/dgop-v0.0.6-linux-amd64";
    hash = "sha256-g0Ov9imPwnuEFAwjL0LAOwrP1TTbS87vsQuGzgiVtw8=";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];
  buildInputs = [ glibc ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/dgop
    chmod +x $out/bin/dgop
  '';

  postFixup = ''
    wrapProgram $out/bin/dgop --prefix PATH : ${lib.makeBinPath [ pciutils ]}
  '';

  meta = with lib; {
    description = "API & CLI for System Resources";
    homepage = "https://github.com/AvengeMedia/dgop";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "dgop";
  };
}
