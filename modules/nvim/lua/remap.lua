vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- lazygit
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { noremap = true, silent = true })

-- telescope
vim.keymap.set('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
vim.keymap.set('n', '<C-p>', "<cmd>lua require('telescope.builtin').git_files()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>fd', "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>fi', "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>fp', ':Telescope project<cr>', { noremap = true })

-- DAP - Debugging
vim.keymap.set('n', '<leader>db', "<cmd>lua require('dap').toggle_breakpoint()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>dc', "<cmd>lua require('dap').continue()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>so', "<cmd>lua require('dap').step_over()<cr>", { noremap = true })
vim.keymap.set('n', '<leader>si', "<cmd>lua require('dap').step_into()<cr>", { noremap = true })

-- DAP STUFF
local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end


