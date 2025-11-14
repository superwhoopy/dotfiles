local config = {}
local wezterm = require 'wezterm'

local SCOOP_DIR = os.getenv("SCOOP") or ''

local function msys_profile(profile)
  if type(profile) == "string" then
    profile = { system = profile, shell = "zsh", args = nil }
  end

  return {
    label = profile.system .. ' ' .. profile.shell,

    -- The argument array specifying the command and its arguments.
    -- If omitted, the default program for the target domain will be
    -- spawned.
    args = profile.args or {
      SCOOP_DIR .. '/apps/msys2/current/usr/bin/' .. profile.shell .. '.exe',
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
      MSYSTEM = profile.system,
      MSYSCON = 'defterm',
      CHERE_INVOKING = 'enabled_from_arguments',
    }
  }
end


local UCRT64_zsh = msys_profile('UCRT64')

local MINGW32_core = msys_profile {
  system = 'MINGW32',
  shell = 'bash (Core)',
  args = {
    'C:/msys32-core/usr/bin/bash.exe',
    '--login',
  }
}

config.launch_menu = {
  UCRT64_zsh,
  {
    label = 'Ubuntu (WSL)',
    args = {
      'C:/Windows/system32/wsl.exe',
      '-d',
      'Ubuntu'
    },
  },
  {
    label = 'PowerShell (Core) 7',
    args = { 'pwsh.exe' },
  },
  {
    label = 'Windows PowerShell',
    args = { 'powershell.exe' },
  },
  {
    label = 'Cmd',
    args = { 'cmd.exe' },
  },
  msys_profile('MINGW64'),
  msys_profile('MSYS'),
  MINGW32_core,
}

-- CAUTION, WIZARDRY AHEAD #####################################################
--
-- We don't want to set the default_prog/set_environment_variables to match
-- UCRT64_zsh, because if we do that all the spawn process will share the same
-- environment variables. In particular, the MSYSTEM variable will be forwarded
-- to all children processes (MSYS or not, btw). To prevent this from happening,
-- we keep a default default_prog (cmd), but instead we define a callback on the
-- event 'gui-startup', to spawn the command that we want. This way, all the
-- processes spawn through SpawnCommand (e.g. when splitting into pane) will
-- only inherit from the default environment variables, not from those of MSYS2.
-- #############################################################################

config._default_spawn_cmd = UCRT64_zsh

wezterm.on('gui-startup', function(_)
  wezterm.mux.spawn_window(config._default_spawn_cmd)
end)


return config
