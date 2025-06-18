{
  lib,
  fetchFromGitHub,
  installShellFiles,
  libX11,
  libinput,
  libxcb,
  libxkbcommon,
  pixman,
  pkg-config,
  stdenv,
  testers,
  wayland,
  wayland-protocols,
  wayland-scanner,
  wlroots,
  writeText,
  xcbutilwm,
  xwayland,
  # Boolean flags
  enableXWayland ? true,
  withCustomConfigH ? (configH != null),
  # Configurable options
  configH ?
    if conf != null then
      lib.warn ''
        conf parameter is deprecated;
        use configH instead
      '' conf
    else
      null,
  # Deprecated options
  # Remove them before next version of either Nixpkgs or nixtile itself
  conf ? null,
}:

assert withCustomConfigH -> (configH != null);
stdenv.mkDerivation (finalAttrs: {
  pname = "nixtile";
  version = "0.8-dev";

  src = fetchFromGitHub {
    owner = "aCeTotal";
    repo = "nixtile";
    rev = "6a31a1b24aa6adb5f7ad89423ac048d22f8955e3";
    sha256 = "sha256-i78+gXTzaHxcGz3CoGNG1W5vyEfKfDqjE+K59zOWij4=";
  };

  nativeBuildInputs = [
    installShellFiles
    pkg-config
    wayland-scanner
  ];

  buildInputs =
    [
      libinput
      libxcb
      libxkbcommon
      pixman
      wayland
      wayland-protocols
      wlroots
    ]
    ++ lib.optionals enableXWayland [
      libX11
      xcbutilwm
      xwayland
    ];

  outputs = [
    "out"
    "man"
  ];

  postPatch =
    let
      configFile =
        if lib.isDerivation configH || builtins.isPath configH then
          configH
        else
          writeText "config.h" configH;
    in
    lib.optionalString withCustomConfigH "cp ${configFile} config.h";

  makeFlags =
    [
      "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
      "WAYLAND_SCANNER=wayland-scanner"
      "PREFIX=$(out)"
      "MANDIR=$(man)/share/man"
    ]
    ++ lib.optionals enableXWayland [
      ''XWAYLAND="-DXWAYLAND"''
      ''XLIBS="xcb xcb-icccm"''
    ];

  strictDeps = true;

  __structuredAttrs = true;

  passthru = {
    tests.version = testers.testVersion {
      package = finalAttrs.finalPackage;
      # `nixtile -v` emits its version string to stderr and returns 1
      command = "nixtile -v 2>&1; return 0";
    };
  };

  meta = {
    homepage = "https://github.com/totalvoid/nixtile";
    description = "Dynamic tiling Wayland compositor based on wlroots";
    longDescription = ''
      nixtile is a compact, hackable compositor for Wayland based on wlroots. It is
      intended to fill the same space in the Wayland world that dwm does in X11,
      primarily in terms of philosophy, and secondarily in terms of
      functionality. Like dwm, nixtile is:

      - Easy to understand, hack on, and extend with patches
      - One C source file (or a very small number) configurable via config.h
      - Tied to as few external dependencies as possible
    '';
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    inherit (wayland.meta) platforms;
    mainProgram = "nixtile";
  };
})
# TODO: custom patches from upstream website
