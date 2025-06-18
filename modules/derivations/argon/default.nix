{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, fontconfig
, freetype
, icu
, libGL
, libinput
, wayland
, nix-update-script
}:

stdenv.mkDerivation rec {
  pname = "argon";
  version = "0.1.1-1";

  src = fetchFromGitHub {
    owner = "aCeTotal";
    repo  = "argon";
    rev   = "fabf440996716456698d90daf8d8cf8fe21db13c";
    hash  = "sha256-w0WtrSArsg/6UVlO4Cp5eqHVWQUZgzc6WuDcfHB81nk=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    libGL      # glesv2_dep
    wayland    # wayland_server_dep
    libinput   # input_dep
    fontconfig # fontconfig_dep
    freetype   # freetype_dep
    icu        # icuuc_dep
  ];

  configurePhase = ''
    mkdir -p build
    # meson.build ligger i repo‐roten, så bruk “.” her
    meson setup --prefix=$out build .
  '';

  buildPhase = ''
    ninja -C build
  '';

  installPhase = ''
    ninja -C build install
  '';

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "C++ Wayland compositor and Vulkan renderer";
    homepage = "https://github.com/aCeTotal/argon";
    mainProgram = "argon";
    maintainers = [ lib.maintainers.dblsaiko ];
    platforms = lib.platforms.linux;
  };
}

