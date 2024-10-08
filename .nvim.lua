if vim.fn.has('win32') == 1 then
  -- launch Windows Sandbox test with :mak
  vim.opt.makeprg = 'start \\%USERPROFILE\\%\\.config\\test\\sandbox.wsb'
end

-- get base neo-tree opts and update them
local opts = require('packages').neotree_opts
opts.filesystem = opts.filesystem or {}
opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
opts.filesystem.filtered_items.visible = true
require('neo-tree').setup(opts)
