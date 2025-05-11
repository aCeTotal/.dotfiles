{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "SpeedTree-Modeler";
  version = "10.0.1";

  src = fetchurl {
    url    = "https://pfoprod.ddns.net/Adrian/Programmer/SpeedTree_Modeler_v${version}_Linux.tar.gz";
    sha256 = "rqjdbP6YtVbzl6jC0iAEXkl4MvIiqEFKUAYqViY3XX4=";
  };

  # X11, xkb- og OpenGL-avhengigheter
  buildInputs = [
    xorg.libxcb
    xorg.xcbutil
    xorg.libX11
    libxkbcommon
    mesa
    libGLU
    libglvnd
    zlib
    libsForQt5.qt5.qtbase
  ];
  nativeBuildInputs = [ coreutils ];
  phases = [ "installPhase" ];

  installPhase = ''
    # 1) Pakk ut programmet til midlertidig tmp
    mkdir tmp
    tar xzf "$src" \
      --strip-components=2 \
      -C tmp \
      SpeedTree_Modeler_v${version}_Linux/SpeedTree_Modeler_v${version}

    # 2) Pakk ut data-arkivet internt
    tar xzf tmp/data -C tmp
    rm tmp/data

    # 3) Kopier alt til $out/data
    mkdir -p $out/data $out/bin $out/share/applications
    cp -r tmp/* $out/data/

    # 4) Gjør binæren kjørbar
    chmod +x $out/data/linux/SpeedTree_Modeler

    # 5) Lag wrapper-script i bin
    cat > $out/bin/speedtree-modeler <<EOF
#!/usr/bin/env bash
# Sett opp nødvendige biblioteksbaner
export LD_LIBRARY_PATH="$out/data:$out/data/linux:${libGLU}/lib:${libxkbcommon}/lib:${libglvnd}/lib:${stdenv.cc.cc.lib}/lib:${xorg.libxcb}/lib:${xorg.libX11}/lib:${zlib}/lib:${qt5.qtbase.out}/lib":$LD_LIBRARY_PATH
# Kjør programmet via Glibc dynamic loader
exec ${pkgs.glibc.out}/lib/ld-linux-x86-64.so.2 \
     "$out/data/linux/SpeedTree_Modeler" "$@"
EOF
    chmod +x $out/bin/speedtree-modeler

    # 6) Opprett .desktop-entry for rofi/menyer
    mkdir -p $out/share/applications
    cat > $out/share/applications/SpeedTree-Modeler.desktop <<EOF
[Desktop Entry]
Name=SpeedTree Modeler ${version}
Comment=SpeedTree procedural modell
Exec=$out/bin/speedtree-modeler
Icon=$out/data/Resources/SpeedTreeIcon.png
Terminal=false
Type=Application
Categories=Graphics;
EOF

    # 7) Rydd opp
    rm -rf tmp
  '';

  meta = with lib; {
    description = "SpeedTree Modeler, versjon ${version}";
    homepage    = "https://store.speedtree.com/";
    license     = licenses.unfree;
    platforms   = platforms.linux;
  };
}

