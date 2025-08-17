{
  stdenv,
  fetchzip,
}:

stdenv.mkDerivation rec {
  pname = "inter-font";
  version = "4.1";

  src = fetchzip {
    url = "https://github.com/rsms/inter/releases/download/v${version}/Inter-${version}.zip";
    hash = "sha256-5vdKKvHAeZi6igrfpbOdhZlDX2/5+UvzlnCQV6DdqoQ=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype

    cp Inter.ttc $out/share/fonts/truetype/
    cp InterVariable.ttf $out/share/fonts/truetype/
    cp InterVariable-Italic.ttf $out/share/fonts/truetype/
  '';
}
