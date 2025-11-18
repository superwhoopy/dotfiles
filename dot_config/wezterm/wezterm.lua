local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local IS_WIN = (wezterm.target_triple == 'x86_64-pc-windows-msvc')
local IS_NUX = (wezterm.target_triple == 'x86_64-unknown-linux-gnu')

local osconfig
if IS_WIN then
  osconfig = require 'win'
elseif IS_NUX then
  osconfig = require 'nux'
end

-- #############################################################################

config.color_scheme = 'OneHalfDark'
config.font = IS_WIN
  and wezterm.font('UbuntuMono Nerd Font')
  or wezterm.font('UbuntuMono')
config.font_size = 11
config.adjust_window_size_when_changing_font_size = false

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.6,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- #############################################################################

config.default_prog = osconfig.default_prog
config.set_environment_variables = osconfig.set_environment_variables

config.launch_menu = osconfig.launch_menu

-- table that can be passed as `choices` parameter to an
-- `InputSelector` action, identical to the choices listed in the launch_menu
local launch_menu_choices = (function ()
  local ret = {}
  for i, v in ipairs(config.launch_menu or {}) do
    table.insert (ret, {
      label = v.label,
      id = tostring(i),
    })
  end
  return ret
end)()

-- Returns a callback function that can be registered with
-- weztern.action_callback(), meant to be used with an InputSelector to split
-- the current pane in a chosen `direction`.
local function split_cb(direction)
  return (function (_, pane, id, label)
    if not id and not label then
      return
    end
    local spawn_cmd = config.launch_menu[tonumber(id)]
    pane:split {
      args = spawn_cmd.args,
      set_environment_variables = spawn_cmd.set_environment_variables,
      direction = direction,
    }
  end)
end

-- #############################################################################

local act = wezterm.action

config.keys = {
  -- NEW TAB
  {
    key = 't', mods = 'CTRL|SHIFT',
    action = act.ShowLauncherArgs(
      { flags = 'TABS|LAUNCH_MENU_ITEMS' })
  },

  -- SPLIT
  {
    key = 'i', mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal(osconfig._default_spawn_cmd or {}),
  },
  {
    key = 'e', mods = 'CTRL|SHIFT',
    action = act.SplitVertical(osconfig._default_spawn_cmd or {}),
  },
  {
    key = 'i', mods = 'CTRL|ALT|SHIFT',
    action = act.InputSelector {
      title = 'Choose a profile to run in the new pane',
      choices = launch_menu_choices,
      action = wezterm.action_callback(split_cb("Right")),
    },
  },
  {
    key = 'e', mods = 'CTRL|ALT|SHIFT',
    action = wezterm.action.InputSelector {
      title = 'Choose a profile to run in the new pane',
      choices = launch_menu_choices,
      action = wezterm.action_callback(split_cb("Bottom")),
    },
  },

  -- MOVE AROUND AND ZOOM
  {
    key = 'h', mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'j', mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'k', mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'l', mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'z', mods = 'CTRL|SHIFT',
    action = act.TogglePaneZoomState
  },

  -- CLOSE
  {
    key = 'w', mods = 'CTRL|SHIFT',
    action = act.CloseCurrentPane { confirm = false }
  },

  -- fullscreen
  {
    key = 'F11',
    action = act.ToggleFullScreen
  },
}

return config
