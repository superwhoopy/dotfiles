local util = require 'lspconfig.util'

local server_log_file = vim.fn.expand('$HOME/psy-ls.log')
return {
  default_config = {
    cmd = {
      vim.fn.expand('$HOME/workspace/lsp-psyc/target/debug/tower-lsp.exe'),
      "-K", vim.fn.expand('$KRONOSAFE_INSTALL_DIR/ksim-9.5.0'),
      "-I", vim.fn.expand('$KRONOSAFE_INSTALL_DIR/psyko-9.5.0/bin/psyko.exe'),
      "-L", server_log_file,
    },
    filetypes = { 'psy' },
    root_dir = function(fname)
      local root_files = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
      }
      return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    single_file_support = true,
  },
  docs = {
    description = [[
Experimental PsyC Language Server
    ]],
  },
}
