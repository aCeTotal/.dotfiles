{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "pureref";
  version = "2.0.2";

  src = if src != null then src else builtins.abort "\e[1;31mERROR: PureRef AppImage ikke funnet. Last ned manuelt fra https://www.pureref.com/download.php og kjør:\n\nnix-store --add-fixed sha256 PureRef-2.0.2_x64.AppImage\n\nDeretter, oppdater 'src' med stien gitt av kommandoen.\e[0m";

  nativeBuildInputs = [ pkgs.coreutils pkgs.bash pkgs.steam-run ];

  unpackPhase = "true";

  buildPhase = ''
    echo "Starting buildPhase"

    mkdir -p $TMPDIR/appimage
    cp $src $TMPDIR/appimage/PureRef.AppImage

    chmod +x $TMPDIR/appimage/PureRef.AppImage

    cd $TMPDIR/appimage
    ./PureRef.AppImage --appimage-extract || { echo "Failed to extract AppImage"; exit 1; }

    echo "BuildPhase complete"
  '';

  installPhase = ''
    echo "Starting installPhase"
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/scalable/apps

    cp -r $TMPDIR/appimage/squashfs-root/* $out/ || { echo "Failed to copy extracted files"; exit 1; }

    cat > $out/bin/pureref <<EOF
#!/bin/sh
exec ${pkgs.steam-run}/bin/steam-run $out/AppRun "\$@"
EOF
    chmod +x $out/bin/pureref

    cat > $out/share/applications/pureref.desktop <<EOF
[Desktop Entry]
Name=PureRef
Comment=Reference Image Viewer
Exec=$out/bin/pureref
Icon=$out/usr/share/icons/hicolor/scalable/apps/pureref.svg
Terminal=false
Type=Application
Categories=Graphics;
EOF

    echo "InstallPhase complete"
  '';

  meta = with pkgs.lib; {
    description = "Reference Image Viewer";
    homepage = "http://www.pureref.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}

