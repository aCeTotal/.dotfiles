{ ... }:


{
    programs.nixvim = {

        plugins = {
            lsp-format.settings = {
                enable = true;
                lspServersToEnable = "all";
                setup.eslint.sync = true;
            };

            lsp = {
                enable = true;
                inlayHints = true;
                servers = {
                    bashls.enable = true;
                    clangd = {
                        enable = true;
                        # Ikke angi --compile-commands-dir — clangd vil som standard lete etter
                        # compile_commands.json i root
                        cmd = [ "clangd" ];
                        # Ekstra flagg om du ønsker bakgrunnsindeksering
                    };
                    gopls.enable = true;
                    nil_ls.enable = true;
                    lua_ls = {
                        enable = true;
                        settings.telemetry.enable = false;
                    };
                    rust_analyzer = {
                        enable = true;
                        installRustc = true;
                        installCargo = true;
                    };
                    marksman.enable = true;
                    # Frontend 
                    html.enable = true;
                    astro.enable = true;
                    tailwindcss.enable = true;
                    ts_ls.enable = true;
                    dockerls.enable = true;
                    cssls.enable = true;
                    emmet_ls.enable = true;
                    eslint.enable = true;
                };
            };
        };
    };
}


