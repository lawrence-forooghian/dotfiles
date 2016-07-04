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

local logger = hs.logger.new("keyboard-layout-switcher", "debug")

function setMostAppropriateKeyboardLayout(loggingReason)
    devices = hs.usb.attachedDevices()

    for key, value in pairs(devices) do
        --- My Filco Majestouch 2 UK
        if value["vendorID"] == 0x04d9 and value["productID"] == 0x1818 then
            setKeyboardLayoutIfNeeded("British - PC", loggingReason)
            return
        end
    end

    setKeyboardLayoutIfNeeded("British", loggingReason)
end

function setKeyboardLayoutIfNeeded(name, loggingReason)
    if hs.keycodes.currentLayout() ~= name then
        if hs.keycodes.setLayout(name) then
            logger.f("Set keyboard layout to %s. (reason: %s)", name, loggingReason)
        else
            logger.ef("Failed to set keyboard layout to %s. (reason: %s)", name, loggingReason)
        end
        hs.openConsole() --- For debug purposes until I get this working properly
    end
end

function usbDevicesChanged(info)
    setMostAppropriateKeyboardLayout("usbDevicesChanged")
end

local usbWatcher = hs.usb.watcher.new(usbDevicesChanged)
usbWatcher:start()

function powerEventHappened(info)
    setMostAppropriateKeyboardLayout("powerEventHappened")
end

local caffeinateWatcher = hs.caffeinate.watcher.new(powerEventHappened)
caffeinateWatcher:start()

--- Add a menu icon for starting the screensaver (I can't find another obvious way of locking the screen without putting the computer to sleep)

local lockMenu = hs.menubar.new()
lockMenu:setTitle(hs.utf8.codepointToUTF8("U+1F4AA"))

function lockMenuClicked()
    -- TODO Investigate: these don't seem to actually work; need to set them in System Preferences
    --hs.execute("defaults write com.apple.screensaver askForPassword -boolean true")
    --hs.execute("defaults write com.apple.screensaver askForPasswordDelay -integer 5")

    hs.execute("pmset displaysleepnow")
end

if lockMenu then
    lockMenu:setClickCallback(lockMenuClicked)
end
