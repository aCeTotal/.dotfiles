{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "SpeedTree-Modeler";
  version = "10.0.1";

  src = fetchurl {
    url = "https://pfoprod.ddns.net/Adrian/Programmer/SpeedTree_Modeler_v${version}_Linux.tar.gz";
    sha256 = "sha256-rqjdbP6YtVbzl6jC0iAEXkl4MvIiqEFKUAYqViY3XX4=";
  };

  # XCB-biblioteker for GUI
  buildInputs = [ xorg.libxcb xorg.xcbutil ];

  nativeBuildInputs = [ coreutils ];
  parallelBuild = false;

  unpackPhase = ''
    # Pakk ut hoved-arkivet
    tar xzf $src

    # Pakk ut data-arkivet i den utpakkede katalogen
    tar xzf \
      SpeedTree_Modeler_v${version}_Linux/SpeedTree_Modeler_v${version}/data \
      -C SpeedTree_Modeler_v${version}_Linux/SpeedTree_Modeler_v${version}

    # Flytt kun data-mappa opp til arbeidstre
    mv SpeedTree_Modeler_v${version}_Linux/SpeedTree_Modeler_v${version}/data ./
  '';

  # Ingen install-skript kjøres lenger

  installPhase = ''
    # Kopier kun data-mappa til utputten
    mkdir -p $out/data
    cp -r data/* $out/data/

    # Gi kjørerettighet til start-scriptet
    chmod u+x $out/data/startSpeedTreeModeler.sh

    # Lag .desktop
    mkdir -p $out/share/applications
    cat > $out/share/applications/SpeedTree-Modeler.desktop <<EOF
[Desktop Entry]
Name=SpeedTree Modeler ${version}
Comment=SpeedTree procedural modell
Exec=${"$out"}/data/startSpeedTreeModeler.sh
Icon=${"$out"}/data/Resources/SpeedTreeIcon.png
Terminal=false
Type=Application
Categories=Graphics;
EOF
  '';

  meta = with lib; {
    description = "SpeedTree Modeler, versjon ${version}";
    homepage    = "https://store.speedtree.com/";
    license     = licenses.unfree;
    platforms   = platforms.linux;
  };
}


