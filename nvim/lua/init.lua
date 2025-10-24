require("ibl").setup {}

local dap = require('dap')
-- GDB Adapter for Remote Debugging
dap.adapters.gdb = {
    type = 'server',
    host = '10.40.62.166',
    port = '1234',
}
-- Remote Debugging Configuration
dap.configurations.cpp = {
    {
        name = "Attach to Remote GDB",
        type = "gdb",
        request = "launch",
        program = "/home/scifi/build-aarch64/bin/nixelfin4k/scifi-server_test",
        cwd = "/home/scifi/build-aarch64/bin/nixelfin4k/",
        stopAtEntry = false,
        runInTerminal = true,
        args = {},
        setupCommands = {
            {
                description = "Enable pretty-printing",
                text = "-enable-pretty-printing",
                ignoreFailures = true,
            },
        },
        pipeTransport = {
            pipeCwd = "",
            pipeProgram = "ssh",
            pipeArgs = { "nates@scifi" },
            debuggerPath = "/usr/bin/gdb",
        },
        sourceFileMap = {
            ["/home/scifi/src"] = "/home/nates/github/headstage/src",
        },
    },
}

require('dap').set_log_level('TRACE')
require('dapui').setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
        },
    },
    floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = "single",
    },
    windows = { indent = 1 },
})
require('nvim-dap-virtual-text').setup()
local dap, dapui = require('dap'), require('dapui')
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

local cmp = require('cmp')
cmp.setup({
  snippet = { expand = function(args) vim.snippet.expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  })
})
cmp.setup.cmdline('/', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
cmp.setup.cmdline(':', { mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = 'path' }, { name = 'cmdline' } }) })
local capabilities = require('cmp_nvim_lsp').default_capabilities()


require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = { 'clangd', 'basedpyright', 'ruff' } })

local function start_lsp(name, cfg)
  cfg = vim.tbl_extend("force", { name = name }, cfg or {})
  pcall(function() vim.lsp.start(cfg) end)
end

if vim.fn.executable("clangd") == 1 then
  start_lsp("clangd", {
    cmd = { "clangd", "--fallback-style=none" },
    root_dir = vim.fs.root(0, { ".git", "compile_commands.json" }) or vim.loop.cwd(),
    on_attach = function(client, _)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.documentOnTypeFormattingProvider = false
    end,
  })
end

if vim.fn.executable("basedpyright-langserver") == 1 then
  start_lsp("basedpyright", {
    cmd = { "basedpyright-langserver", "--stdio" },
    root_dir = vim.fs.root(0, { ".git", "pyproject.toml", "setup.cfg", "setup.py" }) or vim.loop.cwd(),
    settings = { basedpyright = { analysis = { typeCheckingMode = "off" } } },
  })
end

if vim.fn.executable("ruff-lsp") == 1 then
  start_lsp("ruff", { cmd = { "ruff-lsp" } })
end

local actions = require('telescope.actions')
require('telescope').setup{
  pickers = {
    buffers = {
      sort_lastused = true
    }
  }
}
require('telescope').load_extension('file_browser')
require('telescope').load_extension('fzf')

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query"},
  highlight = {
    enable = true,
    custom_captures = {
      ["function.name"] = "FunctionName",
    },
  },
}

require("nvim-tree").setup {}
local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>z", api.tree.toggle, { silent = true, desc = "Toggle nvim-tree" })

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

local tb = require('telescope.builtin')
local function go_def()
  local params = vim.lsp.util.make_position_params()
  local res = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 500)
  if res and next(res) then
    tb.lsp_definitions({ reuse_win = true })
  else
    vim.cmd('silent! tselect ' .. vim.fn.expand('<cword>'))
  end
end

-- vim.keymap.set('n', 'gd', go_def, { silent = true, noremap = true, desc = 'Go to definition (LSP→ctags)' })
-- ensure Telescope is available; set 'gd' with LSP→ctags fallback
local ok_tb, tb = pcall(require, 'telescope.builtin')
local function go_def()
  local params = vim.lsp.util.make_position_params()
  local res = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 400)
  if res and next(res) and ok_tb then
    tb.lsp_definitions({ reuse_win = true })
  elseif vim.fn.executable('ctags') == 1 then
    vim.cmd('silent! tselect ' .. vim.fn.expand('<cword>'))
  else
    vim.lsp.buf.definition()
  end
end
vim.keymap.set('n', 'gd', go_def, { silent = true, noremap = true, desc = 'Go to def (LSP→tags)' })
vim.defer_fn(function()
  if vim.fn.maparg('gd','n') == '' then print('⚠️ gd map not set') end
end, 50)

vim.keymap.set('n', 'gr', tb.lsp_references, { silent = true, noremap = true, desc = 'References' })
vim.keymap.set('n', '<leader>gs', tb.lsp_document_symbols, { silent = true, noremap = true, desc = 'Doc symbols' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, noremap = true, desc = 'Hover doc' })
vim.keymap.set('n', '<leader>h', vim.lsp.buf.format, { silent = true, noremap = true, desc = 'Format buffer' })

-- Setup for <leader>fu (pull up all functions current buffer)
local ts_funcs = function()
  local ft = vim.bo.filetype
  local lang = (ft == 'cpp' or ft == 'cxx' or ft == 'cc') and 'cpp' or (ft == 'c' and 'c' or ft)
  local ok, parsers = pcall(require, 'nvim-treesitter.parsers')
  if not (ok and parsers.has_parser(lang)) then
    vim.notify('No TS parser for ' .. lang, vim.log.levels.WARN)
    return
  end

  -- only capture definitions or declarations with a parameter list "()"
  local query = vim.treesitter.query.parse(
    lang,
    [[
      (function_definition) @def
      (declaration
        declarator: (function_declarator parameters: (parameter_list) @params)
      ) @decl
    ]]
  )

  local parser = vim.treesitter.get_parser(0, lang)
  local tree = parser:parse()[1]:root()
  local items = {}
  for id, node in query:iter_captures(tree, 0, 0, math.huge) do
    local name = vim.treesitter.get_node_text(node, 0)
    if name and not name:match('^%s*$') then
      local sr, sc = node:range()
      table.insert(items, {
        bufnr = 0,
        lnum = sr + 1,
        col = sc + 1,
        text = name:gsub('%s+', ' ')
      })
    end
  end

  require('telescope.pickers').new({}, {
    prompt_title = 'Functions / Methods',
    finder = require('telescope.finders').new_table({
      results = items,
      entry_maker = function(e)
        return {
          value = e,
          display = e.text,
          ordinal = e.text,
          lnum = e.lnum,
          col = e.col,
          filename = vim.api.nvim_buf_get_name(e.bufnr),
        }
      end,
    }),
    sorter = require('telescope.config').values.generic_sorter({}),
    previewer = require('telescope.config').values.qflist_previewer({}),
  }):find()
end

vim.keymap.set('n', '<leader>fu', ts_funcs, { desc = 'List functions/methods in buffer' })



-- Setup for <leader>fiD (pull up all functions current buffer)
local function defs_or_grep_cword()
  local tb = require('telescope.builtin')
  local word = vim.fn.expand('<cword>')
  -- aim the LSP position at the *start* of <cword> on this line
  local line = vim.api.nvim_get_current_line()
  local ms = vim.fn.matchstrpos(line, '\\<' .. vim.fn.escape(word, '\\') .. '\\>')
  local start_col = ms[2] or vim.api.nvim_win_get_cursor(0)[2]
  local pe = (vim.lsp.util._get_position_encoding and vim.lsp.util._get_position_encoding()) or 'utf-16'
  local params = vim.lsp.util.make_position_params(0, pe)
  params.position.character = start_col
  local resp = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 600)
  local locs = {}
  for _, r in pairs(resp or {}) do
    local v = r.result
    if v then
      if vim.islist(v) then vim.list_extend(locs, v) else table.insert(locs, v) end
    end
  end
  if #locs > 0 then
    local all_headers = true
    for _, loc in ipairs(locs) do
      local uri = loc.uri or (loc.targetUri)
      local fname = vim.uri_to_fname(uri)
      if not fname:match('%.h[hpx]?$') then
        all_headers = false
        break
      end
    end
    if all_headers then
      vim.notify('LSP found only headers → grepping: ' .. word, vim.log.levels.WARN, { title = 'fiD' })
      goto grep_fallback
    end
    local items = vim.lsp.util.locations_to_items(locs)
    vim.fn.setqflist({}, 'r', { title = 'Defs for: ' .. word, items = items })
    tb.quickfix({ prompt_title = 'LSP Definitions for: ' .. word })
    return
  end
  vim.notify('no LSP def → grepping: ' .. word, vim.log.levels.WARN, { title = 'fiD' })
  ::grep_fallback::
  tb.live_grep({
    prompt_title = 'Grep for: ' .. word,
    cwd = vim.fn.eval('GitRoot()'),
    default_text = word,
    additional_args = function()
      return { '--word-regexp','--hidden','--glob','!**/tags*','--glob','!**/TAGS','--glob','!**/.tags*' }
    end,
  })
end
vim.keymap.set('n', '<leader>fiD', defs_or_grep_cword, { desc = 'LSP defs → grep <cword>' })



print("\27[32m✔ init.lua loaded successfully!\27[0m")
