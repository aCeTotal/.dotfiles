{ stdenv, lib, fetchurl, makeDesktopItem ? null }:

stdenv.mkDerivation rec {
  pname = "SpeedTree-Modeler";
  version = "10.0.1";

  # Hent fra lokal fil; bytt ut fakeSha256 med ekte hash:
  src = fetchurl {
    url = "file://${HOME}/Downloads/SpeedTree_Modeler_v${version}_Linux.tar.gz";
    sha256 = lib.fakeSha256;  # kjør `nix-prefetch-url file:///home/BRUKER/Downloads/SpeedTree_Modeler_v10.0.1_Linux.tar.gz` for å få ekte verdi
  };

  # Vi trenger ikke runtime-avhengigheter utover sh
  nativeBuildInputs = [];

  # UnpackPhase håndterer .tar.gz automatisk
  # Bare kopier alle filer over til $out
  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
  '';

  # Lag .desktop for rofi / GNOME / KDE
  postInstall = ''
    mkdir -p $out/share/applications
    cat > $out/share/applications/SpeedTree-Modeler.desktop <<EOF
[Desktop Entry]
Name=SpeedTree Modeler ${version}
Comment=SpeedTree procedural modeller
Exec=${"$out"}/startSpeedTreeModeler.sh
Icon=${"$out"}/Resources/SpeedTreeIcon.png
Terminal=false
Type=Application
Categories=Graphics;
EOF
  '';

  meta = with lib; {
    description = "SpeedTree Modeler, versjon ${version}";
    homepage    = "https://store.speedtree.com/";
    license     = licenses.proprietary;
    platforms   = platforms.linux;
  };
}

