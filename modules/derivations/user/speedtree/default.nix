{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  qtbase = libsForQt5.qtbase;
in stdenv.mkDerivation rec {
  pname = "SpeedTree-Modeler";
  version = "10.0.1";

  nativeBuildInputs = [ coreutils patchelf ];
  buildInputs = [
    libxkbcommon
    zlib
    mesa_glu
    libglvnd
    xorg.libX11
    xorg.libxcb
    qtbase
  ];

  src = fetchurl {
    url    = "https://pfoprod.ddns.net/Adrian/Programmer/SpeedTree_Modeler_v${version}_Linux.tar.gz";
    sha256 = "rqjdbP6YtVbzl6jC0iAEXkl4MvIiqEFKUAYqViY3XX4=";
  };

  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    mkdir tmp
    tar xzf "$src" --strip-components=2 \
      -C tmp SpeedTree_Modeler_v${version}_Linux/SpeedTree_Modeler_v${version}
    tar xzf tmp/data -C tmp
    rm tmp/data
  '';

  installPhase = ''
    mkdir -p $out/data $out/bin $out/share/applications

    # Kopier hele strukturen
    cp -r tmp/* $out/data

    # Patche RPATH på hoved‐binæren
    patchelf \
      --set-rpath "\
\$ORIGIN/../data:\
\$ORIGIN/../data/linux:\
${libxkbcommon}/lib:\
${zlib}/lib:\
${mesa_glu}/lib:\
${libglvnd}/lib:\
${xorg.libX11}/lib:\
${xorg.libxcb}/lib:\
${qtbase}/lib" \
      $out/data/linux/SpeedTree_Modeler

    # Wrapper‐script for Qt‐plugin‐path
    cat > $out/bin/speedtree-modeler <<EOF
#!/usr/bin/env bash
export QT_QPA_PLATFORM_PLUGIN_PATH="$out/data/plugins/platforms"
exec "$out/data/linux/SpeedTree_Modeler" "\$@"
EOF
    chmod +x $out/bin/speedtree-modeler

    # .desktop‐entry
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

    rm -rf tmp
  '';

  meta = with lib; {
    description = "SpeedTree Modeler, versjon ${version}";
    homepage    = "https://store.speedtree.com/";
    license     = licenses.unfree;
    platforms   = platforms.linux;
  };
}

