{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "SpeedTree-Modeler";
  version = "10.0.1";

  src = fetchurl {
    url = "https://pfoprod.ddns.net/Adrian/Programmer/SpeedTree_Modeler_v${version}_Linux.tar.gz";
    sha256 = "rqjdbP6YtVbzl6jC0iAEXkl4MvIiqEFKUAYqViY3XX4=";
  };

  # XCB-biblioteker for GUI
  buildInputs = [ xorg.libxcb xorg.xcbutil ];

  nativeBuildInputs = [ coreutils ];

  # Kjør bare unpack + install
  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    # Pakk ut kun innholdet av data-mappa direkte inn i ./data
    mkdir data
    tar xzf $src \
      --strip-components=2 \
      --wildcards \
      SpeedTree_Modeler_v${version}_Linux/SpeedTree_Modeler_v${version}/data/* \
      -C data
  '';

  installPhase = ''
    # Kopier alt fra data/ til $out/data
    mkdir -p $out/data
    cp -r data/* $out/data/

    # Gjør start-script kjørbart
    chmod u+x $out/data/startSpeedTreeModeler.sh

    # Lag .desktop for rofi / meny
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

