local util = require 'lspconfig.util'

local psyls_bin = (vim.fn.has('win32') == 1) and 'psy-ls.exe' or 'psy-ls'
return {
  default_config = {
    name = 'psy-ls',
    cmd = {vim.fn.expand('$HOME/workspace/psyls/target/debug/' .. psyls_bin)},
    filetypes = {'psy'},
    root_dir = function(_)
      return vim.fs.root(0, {'workspace.toml'})
    end,
    single_file_support = true,
  },
  docs = {
    description = [[
Experimental PsyC Language Server
    ]],
  },
}
