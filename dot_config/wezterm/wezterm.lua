local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'OneHalfDark'
config.font = wezterm.font('UbuntuMono Nerd Font')
config.font_size = 11
config.adjust_window_size_when_changing_font_size = false

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

local IS_WIN = (wezterm.target_triple == 'x86_64-pc-windows-msvc')
local IS_NUX = (wezterm.target_triple == 'x86_64-unknown-linux-gnu')

local osconfig
if IS_WIN then
  osconfig = require 'win'
elseif IS_NUX then
  osconfig = require 'nux'
end

-- #############################################################################

config.default_prog = osconfig.default_prog
config.set_environment_variables = osconfig.set_environment_variables

config.launch_menu = osconfig.launch_menu

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
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'e', mods = 'CTRL|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' }
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
