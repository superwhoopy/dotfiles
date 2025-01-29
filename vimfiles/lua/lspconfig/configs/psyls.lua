local util = require 'lspconfig.util'

return {
  default_config = {
    name = 'psy-ls',
    cmd = {vim.fn.expand('$HOME/workspace/psyls/target/debug/psy-ls.exe')},
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
