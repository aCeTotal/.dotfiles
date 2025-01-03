{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "uvtools";
  version = "4.4.3";

  # Last ned AppImage-filen fra GitHub med fast versjon
  src = pkgs.fetchurl {
    url = "https://github.com/sn4k3/UVtools/releases/download/v${version}/UVtools-v${version}-linux-x64.AppImage";
    sha256 = "sha256-hash-for-file"; # Erstatt med riktig SHA256-sjekksum
  };

  nativeBuildInputs = [ pkgs.coreutils pkgs.bash pkgs.steam-run ];

  unpackPhase = ''
    echo "Starting unpackPhase"
    mkdir -p $TMPDIR/appimage
    cp $src $TMPDIR/appimage/UVtools.AppImage
    chmod +x $TMPDIR/appimage/UVtools.AppImage
    cd $TMPDIR/appimage
    ./UVtools.AppImage --appimage-extract || { echo "Failed to extract AppImage"; exit 1; }
    echo "UnpackPhase complete"
  '';

  buildPhase = "true"; # Ingen byggeprosess nødvendig

  installPhase = ''
    echo "Starting installPhase"
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/scalable/apps

    cp -r squashfs-root/* $out/ || { echo "Failed to copy extracted files"; exit 1; }

    # Opprett en wrapper-script for å kjøre UVtools med steam-run
    cat > $out/bin/uvtools <<EOF
#!/bin/sh
exec ${pkgs.steam-run}/bin/steam-run $out/AppRun "\$@"
EOF
    chmod +x $out/bin/uvtools

    # Opprett en desktop-fil for UVtools
    cat > $out/share/applications/uvtools.desktop <<EOF
[Desktop Entry]
Name=UVtools
Comment=3D Print File Analysis and Repair Tool
Exec=$out/bin/uvtools
Icon=$out/usr/share/icons/hicolor/scalable/apps/uvtools.svg
Terminal=false
Type=Application
Categories=Graphics;
EOF

    echo "InstallPhase complete"
  '';

  meta = with pkgs.lib; {
    description = "3D Print File Analysis and Repair Tool";
    homepage = "https://github.com/sn4k3/UVtools";
    license = licenses.gpl3;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}

