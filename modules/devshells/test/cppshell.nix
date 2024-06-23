{pkgs, lib, ...}:{

  environment.systemPackages = [
    (let
      packages = with pkgs; [
          SDL2
          SDL2_image
          SDL2_ttf
          SDL2_net
          SDL2_gfx
          SDL2_Pango
          SDL2_sound
          SDL2_mixer
          nushell
      ];
    in pkgs.runCommand "cppshell" {
      # Dependencies that should exist in the runtime environment
      buildInputs = packages;
      # Dependencies that should only exist in the build environment
      nativeBuildInputs = [ pkgs.makeWrapper ];
    } ''
      mkdir -p $out/bin/
      ln -s ${pkgs.nushell}/bin/nu $out/bin/cppshell
      wrapProgram $out/bin/cppshell --prefix PATH : ${pkgs.lib.makeBinPath packages}
    '')
  ];
}
