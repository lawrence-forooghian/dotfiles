-- Configure Hammerspoon

hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.consoleOnTop(false)
hs.dockIcon(false)
hs.menuIcon(false)

-- Everything in here is pretty much from the tutorial: http://www.hammerspoon.org/go/

-- First, reproduce the SizeUp commands:

local sizeMash = { "ctrl", "alt" }

hs.window.animationDuration = 0

hs.hotkey.bind(sizeMash, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(sizeMash, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(sizeMash, "Space", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    win:setFrame(max)
end)

hs.hotkey.bind("ctrl", "Space", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()

    local screens = hs.screen.allScreens()

    for i = 1, #screens do
        local nextScreen = screens[i]
        if nextScreen ~= screen then
            win:moveToScreen(nextScreen)
            return
        end
    end
end)
