-- #############################################################################
-- OPTIONS
-- #############################################################################

-- floating windows default transparency
vim.o.winblend = 30
-- popup-menu default transparency
vim.o.pumblend = 30

-- colorscheme setting
local colorschemes = {
  Night = 'tokyonight-night',
  Day = 'tokyonight-day',
}
-- by default, stick to dark
vim.cmd("colorscheme " .. colorschemes.Night)
-- commands to switch from light to dark colorscheme
for cmdname, colscheme in pairs(colorschemes) do
  vim.api.nvim_create_user_command(cmdname,
    'colorscheme ' .. colscheme,
    { desc = 'Switch to light colorscheme ' .. colscheme, })
end


-- #############################################################################
-- MAPPINGS
-- #############################################################################
local Snacks = require('snacks')

vim.keymap.set({ 'i', 'n' }, '<C-s>', '<Cmd>w<CR>',
               { desc = "Save current file" })

-- (do not remove trailing whitespaces!)
vim.keymap.set({ 'n' }, '<C-h>', ':vertical botright help ',
               { desc = "Open help in a vertical window" })

vim.keymap.set('n', '<C-Tab>', '<C-]>',
               { desc = "Goto Tag Definition" })
-- do not use <Cmd> or else <C-R><C-W> won't work
vim.keymap.set('n', '<C-S-Tab>', ':ptag <C-r><C-w><CR>',
               { desc = "Open Tag in preview window" })

for direction, key in pairs({ left = 'h', right = 'l', down = 'j', up = 'k' }) do
  vim.keymap.set('n', '<Leader>t' .. key,
                 'yiw<C-W>' .. key .. ':tag <C-R>"<CR>',
                 { desc = "Open tag in window " .. direction })
end

vim.keymap.set('n', '<Leader>sb',
               '<Cmd>lua require("utils").switch_word_under_cursor()<CR>',
               { nowait = true,
                 desc = 'Switch "boolean" word under cursor', })

vim.keymap.set('i', '<C-f>', '<Cmd>call utils#FillLine()<CR>',
   { desc = 'Fill the remaining of the line with a repeated string' })

vim.keymap.set('n', '<C-S-w>', '<Cmd>tabclose<CR>',
  { desc = 'Close the current tab' })

require('which-key').add({
  { "<Leader>d", group = "Diff tools…" },
})
vim.keymap.set({ 'n' }, '<Leader>dt', '<Cmd>diffthis<CR>',
  { desc = 'Enable diff mode on the current buffer' })
vim.keymap.set({ 'n' }, '<Leader>do', '<Cmd>diffoff!<CR>',
  { desc = 'Disable diff mode globally' })

vim.keymap.set({ 'i', 'n' }, '<A-d>', '<Cmd>call utils#DiffSwitch()<CR>',
  { desc = 'Switch diff mode on and off for the current buffer' })

vim.keymap.set('i', '<S-Tab>', '<Cmd>lua require("utils").ShiftTab()<CR>',
  { desc = 'Insert spaces to align with the line above' })

vim.keymap.set('n', '<C-a>', '<Cmd>Alpha<CR>', { desc = 'Goto startup screen' })

vim.keymap.set('n', '<Leader>e', '<Cmd>Neotree reveal toggle<CR>',
               { desc = 'Neotree (reveal toggle)' })

vim.keymap.set('n', '<Leader>S', '<Cmd>lua require("spectre").toggle()<CR>',
               { desc = 'Spectre search & replace (toggle)' })
vim.keymap.set(
  'n', '<leader>sw',
  '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
  { desc = "Search current word in Spectre" }
)

vim.keymap.set(
  { 'n', 'v' }, '<leader>gb',
  function() Snacks.gitbrowse() end,
  { desc = "Git Browse that file at the current location" }
)

-- SNACKS MAPPINGS ##########################################################

vim.keymap.set({ 'n', }, '<C-p>',
               Snacks.picker.files,
               { desc = 'Snacks: Find File' })
vim.keymap.set({ 'n', }, '<C-S-p>',
               Snacks.picker.tags,
               { desc = 'Snacks: Tags' })
vim.keymap.set({ 'n', }, '<C-{>',
               Snacks.picker.lsp_workspace_symbols,
               { desc = 'Snacks: LSP Workspace Symbols' })
vim.keymap.set({ 'n', }, '<C-S-g>',
               function() Snacks.picker.grep({ cmd = "rg" }) end,
               { desc = 'Snacks: Live Grep' })

vim.keymap.set({ 'n', }, '<C-b>',
               Snacks.picker.buffers,
               { desc = 'Snacks: Buffers' })

vim.keymap.set({ 'n', }, '<Leader>p',
               require("telescope").extensions.project.project,
               { desc = 'Telescope: Projects' })
vim.keymap.set({ 'n', }, '<Leader>g',
               Snacks.picker.grep_word,
               { desc = 'Snacks: Grep word under the cursor' })
vim.keymap.set({ 'n', }, '<Leader>D',
               Snacks.picker.diagnostics_buffer,
               { desc = 'Snacks: Diagnostics' })
vim.keymap.set('n', '<leader>cz',
               require("telescope").extensions.chezmoi.find_files,
               { desc = 'Telescope: chezmoi files' })

-- TERMINAL MAPPINGS ###########################################################

-- <C-j><C-j> to exit terminal-mode, do not map <Esc> (to use vim mode as one
-- would expect), and do not map jj either, because its painful when scrolling a
-- pager
vim.keymap.set('t', '<C-j><C-j>', '<C-\\><C-n>',
  { desc = 'Exit Terminal mode' } )

vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h',
  { desc = 'Unfocus from terminal and move to window to the left' })
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j',
  { desc = 'Unfocus from terminal and move to window below' })
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k',
  { desc = 'Unfocus from terminal and move to window above' })
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l',
  { desc = 'Unfocus from terminal and move to window to the right' })


-- LSP SERVERS #################################################################
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float,
               {desc="Open float with diagnostic"})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
               {desc="Goto previous diag. message"})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
               {desc="Goto next diag. message"})
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist,
               {desc="Create a loclist with diag. messages"})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = function(desc)
      return { buffer = ev.buf, desc=desc }
    end
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                   opts("LSP: GoTo Declaration"))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
                   opts("LSP: GoTo Definition"))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                   opts("LSP: Hover"))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
                   opts("LSP: GoTo Implementation"))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
                   opts("LSP: Signature Help"))
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,
                   opts("LSP: Add Folder to Workspace"))
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                   opts("LSP: Remove Folder from Workspace"))
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("LSP: List Folders in Workspace"))
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition,
                   opts("LSP: Type Definition"))
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename,
                   opts("LSP: Rename"))
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action,
                   opts("LSP: Code Action"))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,
                   opts("LSP: References"))
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts("LSP: Format"))
  end,
})

-- TREE-SITTER #################################################################

local function _ts_setup()
  local additional_filetypes = {
    "bash",
    "hjson",
    "javascript",
    "json",
    "powershell",
    "python",
    "rst",
    "rust",
    "tlaplus",
    "toml",
  }
  require('nvim-treesitter').install(additional_filetypes)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = additional_filetypes,
    callback = function()
      vim.treesitter.start()
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  })

end
_ts_setup()

-- OTHER STUFF #################################################################

-- Run exrc file upon changing directory
local initlua_augroup = vim.api.nvim_create_augroup('initlua', {})
vim.api.nvim_create_autocmd('DirChanged', {
  group = initlua_augroup,
  pattern = "*",
  callback = function(args) require('utils').run_exrc(args.file) end
})

-- setup the snippets directory: find where friendly-snippets plugin is
-- installed
local function _find_friendly_snippets_dir()
  local plugins = require('lazy').plugins()
  for _, item in ipairs(plugins) do
    if item[1] == 'rafamadriz/friendly-snippets' then
      return item.dir
    end
  end
  return ""
end
vim.g.vsnip_snippet_dirs = {
  _find_friendly_snippets_dir(),
  vim.fn.stdpath('config') .. '/snippets',
}

-- Define some file types from extensions
vim.filetype.add({
  extension = {
    cmm  = 'practice',
    psy  = 'psy',
    psyh = 'psy',
  }
})

-- Define diagnostics configuration
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "⛔",
      [vim.diagnostic.severity.WARN] = "⚠",
      [vim.diagnostic.severity.HINT] = "💡",
      [vim.diagnostic.severity.INFO] = "ℹ"
    },
  },
  virtual_text  = false, -- hide warn/error messages by default
  virtual_lines = true,
})
