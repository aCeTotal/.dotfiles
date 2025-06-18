{ pkgs ? import <nixpkgs> { } }:

let
  steam-run = pkgs.steam-run-native;
in
pkgs.stdenv.mkDerivation rec {
  pname = "chitubox-free-bin";
  version = "2.1.0";

  src = pkgs.fetchurl {
    url = "https://sac.chitubox.com/software/download.do?softwareId=17839&softwareVersionId=v${version}&fileName=CHITUBOX_V${version}.tar.gz";
    sha256 = "9b14dce266132a08c0534076e1c93b5f7186b35885e96746a6b1836285071743";
  };

  buildInputs = [ steam-run ];

  unpackPhase = ''
    mkdir -p $TMPDIR/source
    cd $TMPDIR/source
    tar -xzf $src
    echo "Innhold etter utpakking:"
    ls -la
  '';

  installPhase = ''
    export INSTALL_ROOT=$TMPDIR/CHITUBOX_Basic
    export OPT_DIR=$out/opt
    export APP_DIR=$OPT_DIR/CHITUBOX_Basic

    echo "Innholdet i source-katalogen etter utpakking:"
    ls -la $TMPDIR/source

    if [ ! -f $TMPDIR/source/CHITUBOX_Basic_Linux_Installer_V2.1.run ]; then
      echo "Filen finnes ikke i source-katalogen."
      exit 1
    fi

    # Kjør installasjonsprogrammet med steam-run
    ${steam-run}/bin/steam-run $TMPDIR/source/CHITUBOX_Basic_Linux_Installer_V2.1.run --root $INSTALL_ROOT --accept-licenses --no-size-checking --accept-messages --confirm-command install
  '';

  meta = with pkgs.lib; {
    description = "All-in-one SLA/DLP/LCD Slicer";
    homepage = "https://www.chitubox.com/download.html";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}

