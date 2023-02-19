
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

require("telescope").load_extension("file_browser")
