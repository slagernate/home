
vim.api.nvim_set_keymap(
  "n",
  "<leader>fb",
  ":Telescope file_browser",
  { noremap = true }
)

-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
  "n",
  "<leader>fb",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua require(\'telescope.builtin\').live_grep({ additional_args = function(opts) return {"--no-ignore"} end })<CR>', { noremap = true, silent = true })

lua require('init')
lua require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query"},
  highlight={enable=true},
}  
