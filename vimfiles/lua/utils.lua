local P = {}
utils = P

-- #############################################################################

--- Correspondence table, used by `switch_word_under_cursor()`
local _switch_table = {
  {'0', '1'},

  {'KTRUE', 'KFALSE'},
  {'true', 'false'},
  {'True', 'False'},
  {'y', 'n'},
  {'yes', 'no'},
  {'YES', 'NO'},

  {'enabled', 'disabled'},
  {'on', 'off'},
  {'ON', 'OFF'},

  {'TASK_STATUS_RUNNING', 'TASK_STATUS_DEAD'},
  {'TASK_AGENT', 'TASK_JOB'},
}

-- build a faster lookup table with every pair declared in _switch_table
local _switch_lookup_table = (function()
  local ans = {}
  for _, vals in ipairs(_switch_table) do
    ans[vals[1]] = vals[2]
    ans[vals[2]] = vals[1]
  end
  return ans
end)()


--- Switch the word under the cursor with its complement, if it exists
-- @see _switch_table
function P.switch_word_under_cursor()
  local word = vim.fn.expand("<cword>")
  local subst = _switch_lookup_table[word]

  if subst ~= nil then
    vim.fn.execute("normal! ciw"..subst)
  else
    print("Don't know how to switch the word "..word.."!")
  end
end

-- #############################################################################

-- TODO
function P.run_exrc(basedir)
  local exrc_lua = basedir .. '/.nvim.lua'
  print('Looking for exrc file in new directory…')
  if vim.fn.filereadable(exrc_lua) == 0 then
    -- file does not exist: nothing to do
    return
  end
  if vim.secure.read(exrc_lua) == nil then
    print('Did not source ' .. exrc_lua .. ': untrusted file')
    return
  end

  -- now we know that exrc_lua exists, and is trusted: source it
  print('Auto-Sourcing file ' .. exrc_lua)
  vim.cmd('luafile ' .. exrc_lua)
end

-- #############################################################################

-- Insert as many whitespaces as necessary at the current position to align the
-- next character on the first non-blank character on the line above
function P.ShiftTab()
  local pos = vim.fn.getpos('.')
  local bufnum = pos[1]
  local lnum   = pos[2]
  local col    = pos[3]

  local current_line = vim.fn.getline(lnum)
  local line_above_content = vim.fn.getline(lnum - 1)
  local spaces_to_insert = ''
  while line_above_content:sub(col, col) == ' ' do
    spaces_to_insert = spaces_to_insert .. ' '
    col = col + 1
  end

  -- insert the necessary number of spaces
  local new_line = current_line:sub(1, col) .. spaces_to_insert
                   .. current_line:sub(col + 1)
  vim.fn.setline(lnum, new_line)
  vim.fn.setpos('.', { bufnum, lnum, col, 0 })
end

return utils

