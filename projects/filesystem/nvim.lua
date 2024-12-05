-- autocommands (auto-clears the group if it exists)
local fs_augroup = vim.api.nvim_create_augroup("filesystem-proj", {})

vim.api.nvim_create_autocmd({"FileType"}, {
  group   = fs_augroup,
  pattern = {"c",},
  callback = function(_)
    vim.o.textwidth = 110
  end
})

-- default make program
vim.o.makeprg = 'meson compile -C build/'

-- disable ALE linting: we're using clangd
local ale_linters = vim.g.ale_linters
ale_linters.c = {}
vim.g.ale_linters = ale_linters
