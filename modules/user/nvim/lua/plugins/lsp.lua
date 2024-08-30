local cmp = require('cmp')
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.clangd.setup{
  cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--background-index",
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    "--clang-tidy",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
  },
  capabilities=capabilities
}



require'lspconfig'.lua_ls.setup{capabilities=capabilities}
require'lspconfig'.rust_analyzer.setup{capabilities=capabilities}
require'lspconfig'.cmake.setup{capabilities=capabilities}
require'lspconfig'.dockerls.setup{capabilities=capabilities}
require'lspconfig'.nixd.setup{capabilities=capabilities}
require'lspconfig'.pyright.setup{
  capabilities=capabilities,
  settings = {
    python = {
      analysis = {       
        typeCheckingMode = "off",                                                                                          
      }
    }
  }   
}

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'buffer' },
    { name = 'path' },
  })
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 100
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
