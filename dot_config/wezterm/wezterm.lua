local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'OneHalfDark'
config.font = wezterm.font('UbuntuMono Nerd Font')
config.font_size = 11

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

local IS_WIN = (wezterm.target_triple == 'x86_64-pc-windows-msvc')
local IS_NUX = (wezterm.target_triple == 'x86_64-unknown-linux-gnu')

-- #############################################################################

local SCOOP_DIR = os.getenv("SCOOP") or ''
local UCRT64_zsh = {
  label = 'UCRT64 zsh',

  -- The argument array specifying the command and its arguments.
  -- If omitted, the default program for the target domain will be
  -- spawned.
  args = {
    SCOOP_DIR .. '/apps/msys2/current/usr/bin/zsh.exe',
    '--login',
    '--interactive',
  },

  -- The current working directory to set for the command.
  -- If omitted, wezterm will infer a value based on the active pane
  -- at the time this action is triggered.  If the active pane
  -- matches the domain specified in this `SpawnCommand` instance
  -- then the current working directory of the active pane will be
  -- used.
  -- If the current working directory cannot be inferred then it
  -- will typically fall back to using the home directory of
  -- the current user.
  -- cwd = '/some/path',

  -- Sets additional environment variables in the environment for
  -- this command invocation.
  set_environment_variables = {
    MSYS = 'winsymlinks:nativestrict',
    MSYS2_PATH_TYPE = 'inherit',
    MSYSTEM = 'UCRT64',
    MSYSCON = 'defterm',
    CHERE_INVOKING = 'enabled_from_arguments',
  },
}

config.default_prog = UCRT64_zsh.args
config.set_environment_variables = UCRT64_zsh.set_environment_variables

config.launch_menu = {
  UCRT64_zsh
}

-- #############################################################################

config.keys = {
  { key = 't', mods = 'CTRL|SHIFT',
    action = wezterm.action.ShowLauncherArgs(
      { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' })
  }
}

return config
