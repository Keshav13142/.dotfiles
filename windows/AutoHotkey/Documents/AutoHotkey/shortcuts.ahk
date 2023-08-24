FocusElseActivate(exe, path) {
  name := exe ".exe"
  if (WinExist("ahk_exe " name)) {
    WinActivate
  }
  else {
    Run(name, path)
  }
}

LocalPath(path) {
  return EnvGet("USERPROFILE") "\AppData\Local\" path
}

; Open apps
!w:: FocusElseActivate("brave", LocalPath("BraveSoftware\Brave-Browser\Application"))
!s:: FocusElseActivate("Everything64", "C:\Program Files\Everything 1.5a")
!c:: FocusElseActivate("Code", LocalPath("Programs\Microsoft VS Code"))
!a:: focuselseactivate("Authy Desktop", localpath("authy"))
!b:: focuselseactivate("Bitwarden", Localpath("Programs\Bitwarden"))
!o:: FocusElseActivate("Obsidian", LocalPath("Obsidian"))
!Enter:: Run "wezterm-gui"

; Toggle fullscreen in supported apps
#f::F11

; Max/minimize windwos
!f:: {
  MX := WinGetMinMax("A")
  if (MX == 1)
    WinRestore("A")
  else
    WinMaximize("A")
}

; Close active window
!q:: {
  if (WinGetTitle("A")) {
    WinClose(WinGetTitle("A"))
  }
  return
}

; Remap Caps to Esc
CapsLock::Escape

; Reload current script
!+r:: Reload