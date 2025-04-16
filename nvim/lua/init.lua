
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

local actions = require('telescope.actions')require('telescope').setup{
  pickers = {
    buffers = {
      sort_lastused = true
    }
  }
}

lua require('init')
lua require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query"},
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight function names
      ["function.name"] = "FunctionName",
    },
  },
}

-- Remove trailing whitespace on save
vim.api.nvim_exec([[
  autocmd BufWritePre * :%s/\s\+$//e
]], false)

require('lspconfig').pylsp.setup{
    root_dir = require('lspconfig/util').root_pattern('.git', 'setup.py', 'pyproject.toml', 'requirements.txt'),
    -- Other configurations here
}

vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true, silent = false})


require('ibl').setup({
    -- Your custom options can go here
})


require('diffview').setup()



