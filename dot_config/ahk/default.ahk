#Requires AutoHotkey v2.0

ScoopDir := EnvGet("SCOOP")
HomeDir := EnvGet("USERPROFILE")

; This function is necessary when mapping to a Win+<X> hotkey: for some reason
; Windows does not let us focus the newly created window by default
RunAndFocus(cmdStr, optStr:="")
{
  pid := unset
  timeout_s := 5 ; wait for 5s to find the newly created window
  Run cmdStr, HomeDir, optStr, &pid
  if WinWait("ahk_pid " pid, , timeout_s)
    WinActivate("ahk_pid " pid)
  return
}

; ##############################################################################
; HOTKEYS
; ##############################################################################

; Neovim
#v:: RunAndFocus(ScoopDir "\apps\neovide\current\neovide.exe")
#+v:: RunAndFocus(ScoopDir "\apps\neovide\current\neovide.exe --fullscreen")

; Browser
#b:: Run("firefox", , "Max")

; Windows Terminal
#Enter:: Run("wezterm start -- msys2.bat -ucrt64 -defterm -here -full-path -shell zsh", , "Hide")

; Switch keyboard layout
Capslock::
{
  Send "#{Space}"
}

; GlazeWM start
#+g::
{
  TrayTip("Starting GlazeWM", , "Iconi")
  Run("glazewm", , "Hide")
}

; Mattermost
#m::
{
  if WinExist("ahk_exe Mattermost.exe")
    WinActivate
  else
    RunAndFocus("mattermost")
}

; French characters (standard Linux shortcuts, see
; https://cogito-ergo-dev.fr/blog/17445/la-typographie-sous-linux/ )
<^>!w::  Send("« ")
<^>!x::  Send(" »")
<^>!o::  Send("œ")
<^>!+o:: Send("Œ")
<^>!+2:: Send("É")
<^>!+7:: Send("È")
<^>!+9:: Send("Ç")
<^>!+0:: Send("À")

; Some characters common to French and English, adapted to both layouts In
; english layout, there is no AltGr key, instead specify "the right Alt key",
; which is symbolized with >! (see AHK documentation, Hotkey Modifier Symbols)

; Narrow non-breaking space (espace fine)
<^>!+Space:: Send("{U+202F}")
; Non-breaking space
<!Space:: Send("{U+00a0}")

<^>!+,:: Send("…")
>!+m:: Send("…")

<^>!+4:: Send("—")
>!+4:: Send("—")

<^>!+5:: Send("–")
>!+5:: Send("–")

<^>!+6:: Send("‑")
>!+6:: Send("‑")

; Reload this script, useful when debugging/prototyping
; #r:: Reload

; Reload zebar
#+z::
{
  if (PID := ProcessExist("zebar.exe")) {
    TrayTip("Restarting Zebar", , "Iconi")
    ProcessClose(PID)
    ProcessWaitClose(PID)
  } else {
    TrayTip("Launching Zebar", , "Iconi")
  }
  Run("cmd /c zebar.exe", , "Hide")
}

; ##############################################################################
; HOTSTRINGS
; ##############################################################################

; reminder on modifiers:
;
;   * means no need for an ending character
;   ? means that the hotstring is triggered even inside other words
;   O means the ending character will be removed
;   C means the hotstring is case sensitive
;
; Also:
;
;   ^    for Ctrl
;   !    for Alt
;   +    for Shift
;   #    for Meta
;   <^>! for AltGr

