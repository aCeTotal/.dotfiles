{ pkgs ? import <nixpkgs> { } }:
with pkgs;

stdenv.mkDerivation rec {
  pname = "chitubox-basic";
  version = "2.1.0";

  src = builtins.fetchTarball {
    url = "https://sac.chitubox.com/software/download.do?softwareId=17839&softwareVersionId=v${version}&fileName=CHITUBOX_V${version}.tar.gz";
    sha256 = "9b14dce266132a08c0534076e1c93b5f7186b35885e96746a6b1836285071743";
  };
  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ stdenv.cc.cc.lib libglvnd libgcrypt zlib glib fontconfig freetype libdrm ];

  buildPhase = ''
    mkdir -p bin
    mv CHITUBOX bin/chitubox

    # Remove unused stuff
    rm AppRun

    # Place resources where ChiTuBox can expect to find them
    mkdir ChiTuBox
    mv resource ChiTuBox/

    # Configure Qt paths
    cat << EOF > bin/qt.conf
      [Paths]
      Prefix = $out
      Plugins = plugins
      Imports = qml
      Qml2Imports = qml
    EOF
  '';

  installPhase = ''
    mkdir -p $out
    mv * $out/
  '';

  meta = {
    description = "A Revolutionary Tool to Change 3D Printing Processes within One Click";
    homepage = "https://www.chitubox.com";
    license = {
      fullName = "ChiTuBox EULA";
      shortName = "ChiTuBox";
      url = "https://www.chitubox.com";
    };
  };
}
