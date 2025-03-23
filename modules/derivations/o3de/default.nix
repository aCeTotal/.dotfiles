{ pkgs ? import <nixpkgs> {} }:
let
  qtbase = pkgs.libsForQt5.qt5.qtbase;
in
pkgs.stdenv.mkDerivation rec {
  pname = "o3de-bin";
  version = "${_stablever}_${_builddate}";

  # Deaktiver Qt-autowrapping for å unngå qtPreHook-feil
  dontWrapQtApps = true;

  failureHook = "";

  _stablever = "2409.1";
  _engver    = "24.09.1";
  _builddate = "20241103";
  _debname   = "o3de_2409_1.deb";
  _binname   = "o3de";

  src = pkgs.fetchurl {
    url = "https://o3debinaries.org/main/Latest/Linux/${_debname}";
    sha256 = "Ze5ZHpzgd0haB79+HC4lbWkj13Flp41lYEWX1HuWoN4=";
  };

  sha256Src = pkgs.fetchurl {
    url = "https://o3debinaries.org/main/Latest/Linux/${_debname}.sha256";
    sha256 = "h7alyd0lgeq0Ln9S8KXum9vx4A9wrAyiPwLTdMEQv/0=";
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

  nativeBuildInputs = with pkgs; [
    binutils
    gnutar
    gnupg
    makeWrapper
    glibc
    patchelf
    file
    qtbase
  ];

  dontStrip = true;

  unpackPhase = ''
    expected=$(cut -d ' ' -f1 "$(readlink -f ${sha256Src})")
    actual=$(sha256sum "$(readlink -f ${src})" | cut -d ' ' -f1)
    if [ "$expected" != "$actual" ]; then
      echo "Checksum verification failed" >&2
      exit 1
    fi

    gpgv --keyring "$(readlink -f ${gpgSrc})" "$(readlink -f ${src})" || {
      echo "PGP verification failed" >&2
      exit 1
    }

    mkdir debdir
    cd debdir
    ar x "$(readlink -f ${src})"
    if [ -f data.tar.gz ]; then
      tar -xzf data.tar.gz
    elif [ -f data.tar.xz ]; then
      tar -xJf data.tar.xz
    else
      echo "No data archive found in deb file." >&2
      exit 1
    fi
    cd ..
  '';

  buildPhase = "true";
  fixupPhase = "true";
  installCheckPhase = "true";

  installPhase = ''
    set -ex
    export pname="${pname}"
    failureHook() { :; }

    mkdir -p $out
    if [ "$(ls -A debdir)" ]; then
      cp -r debdir/* $out/
    else
      echo "No files extracted in debdir. Aborting." >&2
      exit 1
    fi
    if [ ! -d "$out/opt/O3DE/${_engver}" ]; then
      echo "Expected O3DE ${_engver} not found. Aborting." >&2
      exit 1
    fi

    mkdir -p $out/bin
    cp "$out/opt/O3DE/${_engver}/bin/Linux/profile/Default/o3de" $out/bin/
    wrapProgram $out/bin/o3de \
      --prefix LD_LIBRARY_PATH : "$out/opt/O3DE/${_engver}/lib" \
      --prefix LD_LIBRARY_PATH : "${qtbase}/lib"
    if file "$out/bin/.o3de-wrapped" | grep -q ELF; then
      patchelf --set-interpreter "${pkgs.glibc}/lib/ld-linux-x86-64.so.2" "$out/bin/.o3de-wrapped"
    else
      echo "Warning: $out/bin/.o3de-wrapped is not an ELF executable, skipping patchelf." >&2
    fi

    mkdir -p $out/share/applications
    if [ -f ${desktopFile} ]; then
      sed 's/^Exec=.*/Exec=o3de/' ${desktopFile} > $out/share/applications/open-3d-engine.desktop
    else
      echo "Desktop file not found, skipping."
    fi

    mkdir -p $out/share/licenses/${pname}
    install -Dm644 "$(readlink -f ${licenseApacheSrc})" $out/share/licenses/${pname}/LICENSE.txt
    install -Dm644 "$(readlink -f ${licenseMITSrc})" $out/share/licenses/${pname}/LICENSE_MIT.txt
    install -Dm644 "$(readlink -f ${licenseApache2Src})" $out/share/licenses/${pname}/LICENSE_APACHE2.txt

    chmod --reference /opt $out/opt || true
    exit 0
  '';

  meta = with pkgs.lib; {
    description = "Open 3D Engine - An open-source, real-time 3D development engine";
    homepage = "https://o3de.org/";
    license = licenses.mit;
    maintainers = [ "xaque <xaque at duck dot com>" ];
    platforms = [ "x86_64-linux" ];
  };
}

