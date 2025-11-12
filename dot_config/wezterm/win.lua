local config = {}

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
local UNSET_DEFAULT_ENV_VARS = (function ()
  local env = {}
  for k in pairs(UCRT64_zsh.set_environment_variables) do
    env[k] = ""
  end
  return env
end)()

config.default_prog = UCRT64_zsh.args
config.set_environment_variables = UCRT64_zsh.set_environment_variables

-- TODO: it looks like set_environment_variables is broken in the launcher menu:
-- cannot override an environment variable that was defined through
-- config.set_environment_variables?

config.launch_menu = {
  UCRT64_zsh,
  {
    label = 'Ubuntu (WSL)',
    args = {
      'C:/Windows/system32/wsl.exe',
      '-d',
      'Ubuntu'
    },
    set_environment_variables = UNSET_DEFAULT_ENV_VARS,
  },
  {
    label = 'PowerShell (Core) 7',
    args = { 'pwsh.exe' },
    set_environment_variables = UNSET_DEFAULT_ENV_VARS,
  },
  {
    label = 'Windows PowerShell',
    args = { 'powershell.exe' },
    set_environment_variables = UNSET_DEFAULT_ENV_VARS,
  },
  {
    label = 'Cmd',
    args = { 'cmd.exe' },
    set_environment_variables = UNSET_DEFAULT_ENV_VARS,
  },
  msys_profile('MINGW64'),
  msys_profile('MSYS'),
  MINGW32_core,
}

return config
