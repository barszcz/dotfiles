require "string"

local hyper = {"cmd", "shift", "alt", "ctrl"}
local mash = {"cmd", "alt", "ctrl"}
local meh = {"cmd", "alt", "shift"}
local cc = {"cmd", "ctrl"}

function yabai(args)

  return function()
    -- Runs in background very fast
    hs.task.new("/opt/homebrew/bin/yabai",nil, function(ud, ...)
      print("stream", hs.inspect(table.pack(...)))
      return true
    end, args):start()
  end
end

hs.hotkey.bind(hyper, "return", hs.reload)
hs.hotkey.bind(hyper, "r", yabai({"-m", "space", "--rotate", "90"}))
hs.hotkey.bind(hyper, "h", yabai({"-m", "window", "--focus", "west"}))
hs.hotkey.bind(hyper, "j", yabai({"-m", "window", "--focus", "south"}))
hs.hotkey.bind(hyper, "k", yabai({"-m", "window", "--focus", "north"}))
hs.hotkey.bind(hyper, "l", yabai({"-m", "window", "--focus", "east"}))
hs.hotkey.bind(mash, "h", yabai({"-m", "window", "--swap", "west"}))
hs.hotkey.bind(mash, "j", yabai({"-m", "window", "--swap", "south"}))
hs.hotkey.bind(mash, "k", yabai({"-m", "window", "--swap", "north"}))
hs.hotkey.bind(mash, "l", yabai({"-m", "window", "--swap", "east"}))
hs.hotkey.bind(cc, "h", yabai({"-m", "window", "--warp", "west"}))
hs.hotkey.bind(cc, "j", yabai({"-m", "window", "--warp", "south"}))
hs.hotkey.bind(cc, "k", yabai({"-m", "window", "--warp", "north"}))
hs.hotkey.bind(cc, "l", yabai({"-m", "window", "--warp", "east"}))
hs.hotkey.bind(hyper, "m", yabai({"-m", "window", "--focus", "west"}))
hs.hotkey.bind(hyper, "n", yabai({"-m", "window", "--focus", "south"}))
hs.hotkey.bind(hyper, "e", yabai({"-m", "window", "--focus", "north"}))
hs.hotkey.bind(hyper, "i", yabai({"-m", "window", "--focus", "east"}))
hs.hotkey.bind(mash, "m", yabai({"-m", "window", "--swap", "west"}))
hs.hotkey.bind(mash, "n", yabai({"-m", "window", "--swap", "south"}))
hs.hotkey.bind(mash, "e", yabai({"-m", "window", "--swap", "north"}))
hs.hotkey.bind(mash, "i", yabai({"-m", "window", "--swap", "east"}))
hs.hotkey.bind(cc, "m", yabai({"-m", "window", "--warp", "west"}))
hs.hotkey.bind(cc, "n", yabai({"-m", "window", "--warp", "south"}))
hs.hotkey.bind(cc, "e", yabai({"-m", "window", "--warp", "north"}))
hs.hotkey.bind(cc, "i", yabai({"-m", "window", "--warp", "east"}))
hs.hotkey.bind(hyper, "0", yabai({"-m", "space", "--balance"}))
hs.hotkey.bind(hyper, "1", yabai({"-m", "window", "--space", "1"}))
hs.hotkey.bind(hyper, "2", yabai({"-m", "window", "--space", "2"}))
hs.hotkey.bind(hyper, "3", yabai({"-m", "window", "--space", "3"}))
hs.hotkey.bind(hyper, "4", yabai({"-m", "window", "--space", "4"}))
hs.hotkey.bind(hyper, "5", yabai({"-m", "window", "--space", "5"}))
hs.hotkey.bind(hyper, "6", yabai({"-m", "window", "--space", "6"}))
hs.hotkey.bind(hyper, "\\", yabai({"-m", "window", "--toggle", "split"}))
hs.hotkey.bind(hyper, "=", yabai({"-m", "window", "--ratio", "rel:0.05"}))
hs.hotkey.bind(hyper, "-", yabai({"-m", "window", "--ratio", "rel:-0.05"}))
hs.hotkey.bind(hyper, "t", function() hs.osascript.applescript("tell application \"iTerm\" to create window with default profile") end)
hs.hotkey.bind(hyper, "b", function() bluetooth("toggle") end)
hs.hotkey.bind(hyper, "y", yabai({"-m", "config", "layout", "bsp"}))
hs.hotkey.bind(hyper, "f", yabai({"-m", "config", "layout", "float"}))

function checkBluetoothResult(rc, stderr, stderr)
  if rc ~= 0 then
    print(string.format("Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s", rc, stderr, stdout))
  end

end

function bluetooth(power)
  print("Setting bluetooth to " .. power)
  local t = hs.task.new("/opt/homebrew/bin/blueutil", checkBluetoothResult, {"--power", power})
  t:start()
end

function bluetoothHandler(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    bluetooth("off")
  elseif event == hs.caffeinate.watcher.screensDidWake then
    bluetooth("on")
  end
end

watcher = hs.caffeinate.watcher.new(bluetoothHandler)
watcher:start()

function openPrivateWindow() 
  local firefox = hs.application('Firefox')
  firefox:selectMenuItem('New Private Window')
  firefox:activate()
  local ws = firefox:allWindows()
  for key, val in pairs(ws) do
    print(hs.inspect(val))
    if val:title() == 'Mozilla Firefox — Private Browsing' then
      val:focus()
      break
    end
  end
end
hs.hotkey.bind(mash, 'p', openPrivateWindow)

hs.hotkey.bind(mash, "\\", function() yabai({"-m", "window", "--toggle", "split"}) end)

hs.alert.show("Config updated!")
