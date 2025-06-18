{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
    pname = "o3de-bin";
    version = "${_stablever}";

    _stablever = "2409.2";
    _engver    = "24.09.2";
    _debname   = "o3de_2409_2.deb";

    src = pkgs.fetchurl {
        url = "https://o3debinaries.org/main/Latest/Linux/${_debname}";
        sha256 = "zLvT0gn+8Z0XbZ07B6dkRNPmLvcehj8JYI2Q/s931Qc=";
    };

    sha256Src = pkgs.fetchurl {
        url = "https://o3debinaries.org/main/Latest/Linux/${_debname}.sha256";
        sha256 = "A8QMlcU1i0Qr5gw6sGzQdMkidAxtc7bpoh2lcFIbsVg=";
    };

    gpgSrc = pkgs.fetchurl {
        url = "https://o3debinaries.org/main/Latest/Linux/o3de-releases.gpg";
        sha256 = "6b38139f1b8c05495312003b050ab6c2e5bcf7e019a8922bf3440a7d7fa561e5";
    };

    licenseApacheSrc = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/o3de/o3de/main/LICENSE.txt";
        sha256 = "Dq+4TmFe4R3wHbw2qE71xeepYA6tIUh6UY2oUH1vaj0=";
    };

    licenseMITSrc = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/o3de/o3de/main/LICENSE_MIT.TXT";
        sha256 = "xu8crDq8bEi0652EfxuIb3fK1EH3Ng9sVVSjLzgNeW8=";
    };

    licenseApache2Src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/o3de/o3de/main/LICENSE_APACHE2.TXT";
        sha256 = "Wd1Zz71Kf1rwethBoRoYZbYJ5MHtxotBWiQfPcDeEkQ=";
    };

    desktopFile = builtins.toString ./open-3d-engine.desktop;

    nativeBuildInputs = [
        pkgs.binutils
        pkgs.gnutar
        pkgs.gnupg
        pkgs.makeWrapper
        pkgs.glibc
        pkgs.patchelf
        pkgs.file
        pkgs.qt5.wrapQtAppsHook
    ];

    buildInputs = [
        pkgs.qt5.qtbase
        pkgs.python310
        pkgs.libunwind
        pkgs.zstd.dev
        pkgs.zstd.out
        pkgs.gcc-unwrapped.lib
        pkgs.libGL
        pkgs.xorg.libxcb
        pkgs.xorg.xcbutil
        pkgs.xorg.libX11
        pkgs.xorg.libXext
        pkgs.libxkbcommon
        pkgs.xorg.libXrender
        pkgs.xorg.libXcursor
        pkgs.xorg.libXi
        pkgs.xorg.libXtst
    ];

    qtWrapperArgs = [
        "--set" "O3DE_HOME" "${placeholder "out"}/opt/O3DE/${_engver}"
        "--set" "PYTHONHOME" "${placeholder "out"}/opt/O3DE/${_engver}/python"
        "--set" "HOME" "${placeholder "out"}"
        "--set" "XDG_CACHE_HOME" "${placeholder "out"}/.cache"
        "--prefix" "PATH" ":" "${pkgs.python310}/bin"
        "--prefix" "LD_LIBRARY_PATH" ":" "${placeholder "out"}/opt/O3DE/${_engver}/bin/Linux/profile/Default:${pkgs.qt5.qtbase.out}/lib:${pkgs.libGL}/lib:${pkgs.python310}/lib:${pkgs.libunwind}/lib:${pkgs.gcc-unwrapped.lib}/lib:${pkgs.zstd.out}/lib:${pkgs.xorg.libX11}/lib:${pkgs.xorg.libxcb}/lib:${pkgs.xorg.xcbutil}/lib:${pkgs.libxkbcommon}/lib"
    ];



    dontStrip = true;

    unpackPhase = ''
    expected=$(cut -d ' ' -f1 "$(readlink -f ${sha256Src})")
    actual=$(sha256sum "$(readlink -f ${src})" | cut -d ' ' -f1)
    [ "$expected" != "$actual" ] && { echo "Checksum failed"; exit 1; }

    gpgv --keyring "$(readlink -f ${gpgSrc})" "$(readlink -f ${src})" || { echo "PGP verification failed"; exit 1; }

    mkdir debdir && cd debdir
    ar x "$(readlink -f ${src})"
    [ -f data.tar.gz ] && tar -xzf data.tar.gz
    [ -f data.tar.xz ] && tar -xJf data.tar.xz
    cd ..
    '';

    buildPhase = "true";
    fixupPhase = "true";
    installPhase = ''
  mkdir -p $out
  cp -r debdir/* $out/

  mkdir -p $out/bin
  cp "$out/opt/O3DE/${_engver}/bin/Linux/profile/Default/o3de" $out/bin/o3de-unwrapped

  patchelf --set-interpreter "${pkgs.glibc}/lib/ld-linux-x86-64.so.2" \
  --set-rpath "$out/opt/O3DE/${_engver}/bin/Linux/profile/Default:${pkgs.qt5.qtbase.out}/lib:${pkgs.libGL}/lib:${pkgs.python310}/lib:${pkgs.libunwind}/lib:${pkgs.gcc-unwrapped.lib}/lib:${pkgs.zstd.out}/lib:${pkgs.xorg.libX11}/lib:${pkgs.xorg.libxcb}/lib:${pkgs.xorg.xcbutil}/lib:${pkgs.libxkbcommon}/lib" \
  "$out/bin/o3de-unwrapped"

  wrapQtApp $out/bin/o3de-unwrapped

  cat > $out/bin/o3de <<EOF
  #!/bin/sh
  export PYTHONPATH="$out/lib/python3.10/site-packages:\$PYTHONPATH"
  exec -a o3de $out/bin/o3de-unwrapped "\$@"
  EOF

  chmod +x $out/bin/o3de

  mkdir -p $out/lib/python3.10/site-packages/o3de
  cat > $out/lib/python3.10/site-packages/o3de/__init__.py <<EOF
  # empty
  EOF

  cat > $out/lib/python3.10/site-packages/o3de/__main__.py <<EOF
  import os
  import subprocess
  import sys

  editor = os.path.join(os.environ.get("O3DE_HOME", ""), "bin/Linux/profile/Default/o3de")

  if not editor or not os.path.isfile(editor):
    print(f"🚨 Fant ikke O3DE-editoren: {editor}")
    sys.exit(1)

  try:
    subprocess.run([editor] + sys.argv[1:], check=True)
  except subprocess.CalledProcessError as e:
    print(f"🚨 Editor feilet med kode {e.returncode}")
    sys.exit(e.returncode)
  EOF

 
  cat > $out/bin/o3de-cli <<EOF
  #!/bin/sh
  export PYTHONPATH="$out/lib/python3.10/site-packages:\$PYTHONPATH"
  exec ${pkgs.python310}/bin/python3.10 -m o3de "\$@"
  EOF
  chmod +x $out/bin/o3de-cli
  

  mkdir -p $out/share/licenses/${pname}
  install -Dm644 "$(readlink -f ${licenseApacheSrc})" $out/share/licenses/${pname}/LICENSE.txt
  install -Dm644 "$(readlink -f ${licenseMITSrc})" $out/share/licenses/${pname}/LICENSE_MIT.txt
  install -Dm644 "$(readlink -f ${licenseApache2Src})" $out/share/licenses/${pname}/LICENSE_APACHE2.txt
  '';

    postInstall = ''
    env -u PYTHONHOME ${pkgs.python310}/bin/python3.10 -m venv $out/opt/O3DE/${_engver}/python/venv --without-pip || true
    '';


}

