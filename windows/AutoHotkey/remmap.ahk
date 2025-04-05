#Requires AutoHotkey v2.0

*CapsLock::
{
    KeyWait "CapsLock", "T0.1"
    if GetKeyState("CapsLock", "P") {
        return
    }
    Send "{Escape}"
}

#HotIf GetKeyState("CapsLock", "P")
    k::Up
    h::Left
    j::Down
    l::Right

    [::Home
    ]::End

    `;::Delete
    '::BackSpace
#HotIf

