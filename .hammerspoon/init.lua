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

-- And now, replace Caffeine:

local caffeine = hs.menubar.new()
local SLEEP_TYPE = "displayIdle"
local CAFFEINATE_SETTINGS_KEY = "lawrence.caffeinate.displayIdle"

function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle(hs.utf8.codepointToUTF8("U+2615"))
    else
        caffeine:setTitle(hs.utf8.codepointToUTF8("U+1F31A"))
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle(SLEEP_TYPE))
    hs.settings.set(CAFFEINATE_SETTINGS_KEY, hs.caffeinate.get(SLEEP_TYPE))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    hs.caffeinate.set(SLEEP_TYPE, hs.settings.get(CAFFEINATE_SETTINGS_KEY))
    setCaffeineDisplay(hs.caffeinate.get(SLEEP_TYPE))
end
