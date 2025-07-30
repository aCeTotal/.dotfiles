{ pkgs, 
  lib,
  stdenv,
  fetchFromGitHub,
  python3,
  makeDesktopItem,
  copyDesktopItems,
  makeWrapper,
  makeSetupHook,
}:

let
  pydeps = python3.withPackages (ps: with ps; [
    numpy
    pyqt5
    pyopengl
    pygments    # Optional for IPython Qt Console plugin
    # distro package could be added for detection in debug output
  ]);
  
  # Assets use the same version as makehuman, but we could specify a specific commit if needed
  assets_commit = "v1.3.0"; 
in
stdenv.mkDerivation rec {
  pname = "makehuman";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "makehumancommunity";
    repo = "makehuman";
    rev = "v${version}";
    hash = "sha256-x0v/SkwtOl1lkVi2TRuIgx2Xgz4JcWD3He7NhU44Js4=";
  };

  assets = fetchFromGitHub {
    owner = "makehumancommunity";
    repo = "makehuman-assets";
    rev = assets_commit;
    hash = "sha256-Jd2A0PAHVdFMnDLq4Mu5wsK/E6A4QpKjUyv66ix1Gbo=";
  };

  nativeBuildInputs = [
    python3
    makeWrapper
    copyDesktopItems
    pkgs.qt5.wrapQtAppsHook
  ];
  
  buildInputs = [
    pydeps
    pkgs.qt5.qtsvg
    pkgs.hicolor-icon-theme
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "MakeHuman";
      exec = "makehuman";
      icon = "makehuman";
      desktopName = "MakeHuman";
      genericName = "3D character creation";
      comment = "Parametrical modeling program for creating human bodies";
      categories = [ "Graphics" "3DGraphics" ];
    })
  ];

  dontConfigure = true;

  # Prepare and patch phase - similar to prepare() in PKGBUILD
  prePatch = ''
    # Copy files from assets repo to makehuman data directory
    cp -r $assets/base/* $src/makehuman/data/

    # Create .git directory to make build_prepare.py happy
    mkdir -p $src/.git

    # Enable release build and set version information
    cd $src/buildscripts
    sed -e '/#isRelease = True/s/^#//' \
        -e 's/#version=.*$/version=${version}/' \
        -e '/#gitBranch=master/s/^#//' \
        < build.conf.example > build.conf

    # Create wrapper script
    mkdir -p $out/bin
    cat > $out/bin/makehuman << EOF
    #!/bin/sh
    # Apply PyOpenGL patch before starting MakeHuman
    ${pyOpenGLPatchScript}/bin/pyopengl-patch.py || echo "Failed to patch PyOpenGL, continuing anyway"
    cd $out/opt/makehuman && exec python3 makehuman.py "\$@"
    EOF
    chmod +x $out/bin/makehuman
  '';

  # Create patches for NumPy 2.0 compatibility
  patches = [
    # Replace np.fromstring with np.frombuffer for NumPy 2.0 compatibility
    (pkgs.writeText "numpy-compat.patch" '''
      diff --git a/makehuman/makehuman.py b/makehuman/makehuman.py
      --- a/makehuman/makehuman.py
      +++ b/makehuman/makehuman.py
      @@ -0,0 +1 @@
      +# numpy 2.x compatibility patch
      diff --git a/makehuman/makehuman.py b/makehuman/makehuman.py
      --- a/makehuman/makehuman.py
      +++ b/makehuman/makehuman.py
      @@ -802,7 +802,7 @@
           def loadUnicodeTables():
               """Load unicode mapping tables for converting ASCII text to unicode and back."""
               '''Using an indirect way of defining the mapping tables for python3 compatibility.'''
      -        text = np.fromstring(text, dtype='S1')
      +        text = np.frombuffer(text.encode(), dtype='S1')
               # Map character codes to their unicode name
               for i in range(32, 128):
                   ascii2unicode[i] = text[i-32]
      diff --git a/makehuman/lib/image_qt.py b/makehuman/lib/image_qt.py
      --- a/makehuman/lib/image_qt.py
      +++ b/makehuman/lib/image_qt.py
      @@ -62,7 +62,7 @@
               h = image.height()
               # ARGB32 or RGBA8888 => R+G+B+A per byte, last byte is A
               pixels = image.bits().asstring(h * w * 4)
      -        pixels = np.fromstring(pixels, dtype=np.uint32).reshape((h, w))
      +        pixels = np.frombuffer(pixels, dtype=np.uint32).reshape((h, w))
               # Note that QImage stores it as BGRA, we need to convert to RGBA
               # 0xAARRGGBB -> 0xAARRGGBB
               # return (pixels & 0xFF000000) + ((pixels & 0x00FF0000) >> 16) + (pixels & 0x0000FF00) + ((pixels & 0x000000FF) << 16)
      diff --git a/makehuman/lib/shader.py b/makehuman/lib/shader.py
      --- a/makehuman/lib/shader.py
      +++ b/makehuman/lib/shader.py
      @@ -461,6 +461,19 @@
           def getUniforms(self):
               """Retrieve uniform variables from shader program."""
      +        # Helper function for numpy array boolean checks
      +        def safe_is_truthy(value):
      +            """Safely evaluate truthiness for both arrays and scalar values"""
      +            if hasattr(value, 'any'):
      +                # It's an array-like object
      +                return value.any()
      +            else:
      +                # It's a regular scalar value
      +                return bool(value)
      +
      +        def safe_is_falsy(value):
      +            """Safely evaluate falsiness for both arrays and scalar values"""
      +            return not safe_is_truthy(value)
      +
               result = []
               for index, name in enumerate(self.uniformVars):
                   if not name:
      @@ -461,7 +474,7 @@
               result = []
               for index, name in enumerate(self.uniformVars):
      -            if not name:
      +            if safe_is_falsy(name):
                       continue
                   location = glGetUniformLocation(self.shaderId, name)
                   # Protect against GL implementations that assign a location == -1
    ''')
  ];

  # Build phase - similar to build() in PKGBUILD
  buildPhase = ''
    patchShebangs .
    python buildscripts/build_prepare.py --nodownload . "$NIX_BUILD_TOP/build"

    # compile python bytecode
    python -m compileall -o 0 -o 1 -s "$NIX_BUILD_TOP/build" -p /opt "$NIX_BUILD_TOP/build/$pname"
  '';

  # Create PyOpenGL patch script
  pyOpenGLPatchScript = pkgs.writeTextFile {
    name = "pyopengl-patch.py";
    text = ''
    import sys
    import os
    import site
    
    # Get all site-packages directories
    site_packages = site.getsitepackages()
    
    # Look for PyOpenGL in site-packages
    pyopengl_found = False
    for site_dir in site_packages:
        gl_path = os.path.join(site_dir, "OpenGL", "GL", "VERSION", "GL_2_0.py")
        if os.path.exists(gl_path):
            print(f"Found PyOpenGL at {gl_path}")
            pyopengl_found = True
            
            # Add helper functions for NumPy 2.x compatibility
            with open(gl_path, 'r') as f:
                content = f.read()
                
            # Check if we've already patched it
            if "safe_is_truthy" in content:
                print("PyOpenGL already patched, skipping")
                sys.exit(0)
                
            # Helper for safe boolean evaluation of NumPy arrays
            numpy_safety_code = """
            # Helper functions for NumPy 2.x compatibility
            def safe_is_truthy(value):
                import numpy as np
                if isinstance(value, np.ndarray):
                    return value.size > 0 and bool(value.any())
                return bool(value)
                
            def safe_is_falsy(value):
                import numpy as np
                if isinstance(value, np.ndarray):
                    return value.size == 0 or not bool(value.any()) 
                return not bool(value)
            """
            
            # Add our helper functions near the top of the file
            import_line = "from OpenGL.raw.GL.VERSION.GL_2_0 import"
            if import_line in content:
                parts = content.split(import_line, 1)
                content = parts[0] + import_line + parts[1].split("\n", 1)[0] + "\n" + numpy_safety_code + parts[1].split("\n", 1)[1]
                
                # Replace the problematic line in glGetUniformLocation
                if "def glGetUniformLocation" in content:
                    content = content.replace("if not name:", "if safe_is_falsy(name):")
                    
                # Write the modified file back
                with open(gl_path, 'w') as f:
                    f.write(content)
                    
                print(f"Patched {gl_path} for NumPy 2.x compatibility")
            else:
                print(f"Could not find import line in {gl_path}, skipping patch")
                
    if not pyopengl_found:
        print("Could not find PyOpenGL installation")
        sys.exit(1)
    '';
    executable = true;
    destination = "/bin/pyopengl-patch.py";
  };
  
  # Setup build phase
  preBuild = '''';

  # Install phase - similar to package() in PKGBUILD
  installPhase = ''
    # Create opt directory and copy makehuman into it
    install -d $out/opt
    cp -r "$NIX_BUILD_TOP/build/$pname" $out/opt/

    # Remove empty directories
    find $out/opt/$pname -empty -type d -delete

    # Remove exec permission from regular files except makehuman.py
    find $out/opt/$pname -executable -type f -exec chmod a-x '{}' \;
    chmod a+x $out/opt/$pname/$pname.py

    # Install icons
    install -d $out/share/icons/hicolor/32x32/apps
    install -Dm644 $src/$pname/icons/$pname.png $out/share/icons/hicolor/32x32/apps/
    install -Dm644 $src/$pname/icons/$pname.svg $out/share/icons/hicolor/scalable/apps/

    # Create bin symlink
    install -d $out/bin
    makeWrapper $out/opt/$pname/$pname.py $out/bin/$pname \
      --prefix PYTHONPATH : "$PYTHONPATH" \
      --prefix QT_PLUGIN_PATH : "$QT_PLUGIN_PATH"
  '';

  meta = {
    description = "Software to create realistic humans";
    homepage = "http://www.makehumancommunity.org/";
    license = with lib.licenses; [
      agpl3Plus
      cc0
    ];
    longDescription = ''
      MakeHuman is a GUI program for procedurally generating
      realistic-looking humans.
    '';
    mainProgram = "makehuman";
    maintainers = with lib.maintainers; [ elisesouche ];
    platforms = lib.platforms.all;
  };
}
