{pkgs, lib, ...}:{

  environment.systemPackages = [
    # Install the wrapper into the system
    (let
      packages = with pkgs; [
          nodejs_20
          nodePackages.pnpm
          nushell
      ];
    in pkgs.runCommand "dev-shell" {
      # Dependencies that should exist in the runtime environment
      buildInputs = packages;
      # Dependencies that should only exist in the build environment
      nativeBuildInputs = [ pkgs.makeWrapper ];
    } ''
      mkdir -p $out/bin/
      ln -s ${pkgs.nushell}/bin/nu $out/bin/dev-shell
      wrapProgram $out/bin/dev-shell --prefix PATH : ${pkgs.lib.makeBinPath packages}
    '')
  ];
}
