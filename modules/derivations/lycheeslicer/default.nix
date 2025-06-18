{ pkgs ? import <nixpkgs> { } }:

let
  pkgname = "lycheeslicer";
  pkgver = "6.2.0";
  src = pkgs.fetchurl {
    url = "https://mango-lychee.nyc3.cdn.digitaloceanspaces.com/LycheeSlicer-${pkgver}.deb";
    sha512 = "e4ddc961d53026f379ad9484d577409020660c522cb57890fc01e6ead80999d32f926efc2a9a02fdadd61ea652a46b7ca11b8fe0328db832165a6267a3af7612";
  };
  mimeFile = pkgs.fetchurl {
    url = "local://lycheeslicer.xml";
    sha512 = "aba52d9bd76619f66fac0688c1c04846e630f5b8acba6032c61f46a4bcf9ff9d5aa1eb11a3901e85bce33e179d4ccc1f574b06c9ad3f415a692ff4ad39c77f49";
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = pkgname;
  version = pkgver;

  srcs = [ src mimeFile ];

  nativeBuildInputs = [ pkgs.binutils ];

  buildInputs = [
    pkgs.gtk3
    pkgs.libsecret
    pkgs.libnotify
    pkgs.nss
    pkgs.libxss
    pkgs.libxtst
    pkgs.xdg_utils
    pkgs.at_spi2_atk
    pkgs.at_spi2_core
  ];

  optionalBuildInputs = [ pkgs.libappindicator-gtk3 ];

  meta = with pkgs.lib; {
    description = "Lychee Slicer";
    homepage = "http://mango3d.io";
    license = licenses.unfree;
    maintainers = with maintainers; [ your_name_here ];
    platforms = platforms.linux;
  };

  unpackPhase = ''
    dpkg-deb -x ${src} $TMPDIR
  '';

  installPhase = ''
    mkdir -p $out/usr
    cp -r $TMPDIR/usr/* $out/usr/
    install -Dm644 ${mimeFile} $out/usr/share/mime/packages/lycheeslicer.xml
  '';
}

