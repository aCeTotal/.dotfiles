{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "pureref";
  version = "2.0.2";

  # Bruker den lokale .AppImage-filen som kilde
  src = /home/total/.dotfiles/packages/PureRef-2.0.2_x64.Appimage;

  nativeBuildInputs = [ pkgs.coreutils pkgs.bash ];

  unpackPhase = "true"; # Vi hopper over den vanlige unpackPhase.

  buildPhase = ''
    echo "Starting buildPhase"

    # Sørg for at AppImage-filen er kjørbar
    chmod +x $src

    # Pakk ut AppImage-filen
    mkdir -p $TMPDIR/appimage
    $src --appimage-extract || { echo "Failed to extract AppImage"; exit 1; }

    echo "BuildPhase complete"
  '';

  installPhase = ''
    echo "Starting installPhase"
    cp -r $TMPDIR/appimage/squashfs-root/* $out/ || { echo "Failed to copy extracted files"; exit 1; }
    echo "InstallPhase complete"
  '';

  meta = with pkgs.lib; {
    description = "Reference Image Viewer";
    homepage = "http://www.pureref.com";
    license = licenses.unfree; # License is unknown, but not free
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}

