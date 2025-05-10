#NoEnv
SendMode, Input

*CapsLock::
    KeyWait. CapsLock, T0.1
    if GetKeyState("CapsLock", "P")
        return
    Send, {Escape}
return

#If GetKeyState("CapsLock", "P")
    k::Send, {UP}
    h::Send, {LEFT}
    j::Send, {DOWN}
    l::Send, {RIGHT}

    [::Send, {Home}
    ]::Send, {End}

    `;::Send, {Delete}
    `'::Send, {BackSpace}
#If

^!t::
    xl := ComObjActive("Excel.Application")

    if !xl {
        MsgBox, "Excel is not running."
        return
    }

    sheet := xl.ActiveSheet
    sel := xl.Selection

    sheet.Columns(1).TextToColumns(sheet.Range("A1"),1, 1, 0, 1, 0, 0, 0, 0)
    sheet.Columns.AutoFit()
    sheet.Columns(12).NumberFormat := "[$-en-US]dd/mmm/yyyy;@"
    sheet.Range("A1").CurrentRegion.AutoFilter

    xl := ""
    sheet := ""
    sel:= ""
return

^!r::Reload
^!p::Suspend

OpenOrFocus(exe, WinTitle, useRegex:= false){
    if(useRegex){
        SetTitleMatchMode, Regex
    }

    IfWinExist, %WinTitle%
        WinActivate
    else
        RunWait, %exe%
}

!q::WinClose, A
!+m::WinMinimize, A
!f::
    WinGet, MinMaxState, MinMax, A
    if(MinMaxState = 1)
        WinRestore, A
    else
        WinMaximize, A
return

SendClipboardContent(content){
    Clipboard := content
    Send, ^v
    Clipboard := ""
}

SetTitleMatchMode,

!]::
    CycleSameAppWindows("right")
return

!]::
    CycleSameAppWindows("left")
return

CycleSameAppWindows(dir){
    Winget, currentId, ID, A
    Winget, currentExe, ProcessName, ahk_id %currentId%
    Winget, windowList, List

    sameAppWindows := []

    Loop, %windowList% {
        thisID := windowList%A_Index%
        Winget, thisExe, ProcessName, ahk_id %thisID%
        res := thisExe=currentExe
        if(res){
            sameAppWindows.Push(thisID)
        }
    }

    if(sameAppWindows.Length() < 2)
        return

    currentIndex := 0
    Loop, % sameAppWindows.Length() {
        if(sameAppWindows[A_Index] = currentId){
            currentIndex := A_Index
            break
        }
    }

    if(dir = "right")
        nextIndex := Mod(currentIndexm sameAppWindows.Length()) + 1
    else if(dir = "left"){
        nextIndex := currentIndex -1
        if(nextIndex < 1)
            nextIndex := sameAppWindows.Length()
    }

    nextId := sameAppWindows[nextIndex]
    WinActivate, ahk_id %nextIndex%
}
