{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "uvtools";
  version = "v5.0.3";

  src = builtins.fetchurl {
    url = "https://github.com/sn4k3/UVtools/releases/download/${version}/UVtools_linux-x64_${version}.AppImage";
    sha256 = "0685idp886rpzdhqkknhsg7y3yrmvs3lm3yvhnzlpxcalbchc2nh";
  };

nativeBuildInputs = [
    pkgs.coreutils
    pkgs.bash
    pkgs.steam-run
    pkgs.icu
    pkgs.ffmpeg
    pkgs.fuse
    pkgs.libdc1394
    pkgs.libgdiplus
    pkgs.libgeotiff
    pkgs.libjpeg_turbo
    pkgs.libpng
    pkgs.openexr
    pkgs.openjpeg
    pkgs.tbb
    pkgs.zlib
  ];

  unpackPhase = "true";
  buildPhase = "true";

  installPhase = ''
    echo "Creating a wrapper for UVtools"
    mkdir -p $out/bin

    cat > $out/bin/uvtools <<EOF
#!/bin/sh
exec env LD_LIBRARY_PATH=${pkgs.icu}/lib:\$LD_LIBRARY_PATH \
    ${pkgs.appimage-run}/bin/appimage-run ${src} "\$@"
EOF
    chmod +x $out/bin/uvtools
  '';

  meta = with pkgs.lib; {
    description = "3D Print File Analysis and Repair Tool";
    homepage = "https://github.com/sn4k3/UVtools";
    license = licenses.gpl3;
    platforms = [ "x86_64-linux" ];
  };
}
