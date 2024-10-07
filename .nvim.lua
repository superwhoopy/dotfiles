if vim.fn.has('win32') == 1 then
  -- launch Windows Sandbox test with :mak
  vim.opt.makeprg = 'start \\%USERPROFILE\\%\\.config\\test\\sandbox.wsb'
end
