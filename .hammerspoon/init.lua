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
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle(hs.utf8.codepointToUTF8("U+2615"))
    else
        caffeine:setTitle(hs.utf8.codepointToUTF8("U+1F31A"))
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

--- Automatically switch to most appropriate layout for connected keyboard.
function setMostAppropriateKeyboardLayout()
    devices = hs.usb.attachedDevices()

    for key, value in pairs(devices) do
        --- My Filco Majestouch 2 UK
        if value["vendorID"] == 0x04d9 and value["productID"] == 0x1818 then
            hs.keycodes.setLayout("British - PC")
            return
        end
    end

    hs.keycodes.setLayout("British")
end

function usbDevicesChanged(info)
    setMostAppropriateKeyboardLayout()
end

local usbWatcher = hs.usb.watcher.new(usbDevicesChanged)
usbWatcher:start()

setMostAppropriateKeyboardLayout()
