with import <nixpkgs> {};

mkShell {
  name = "cpp_shell";
  buildInputs =  with pkgs; [
    direnv
    cmake
    clang_17
    gcc
  ];

  shellHook =
  ''
  '';
}
