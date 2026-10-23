-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Gigabyte home Monitor
hl.monitor({ output = "DP-5", mode = "preferred", position = "0x0", scale = 1 })

-- Match this Dell by identity, not its dock's changing DP connector number.
local dell_description = "Dell Inc. DELL S2721QS 9BNXZY3"
hl.monitor({ output = "desc:" .. dell_description, mode = "preferred", position = "0x0", scale = 1.25 })

-- Dell Laptop Display
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.25 })

--
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.25 })

-- Recalculate from logical pixels so alignment respects each display's scale.
-- Unknown external displays keep the normal automatic layout.
local function arrange_laptop()
  local laptop, dell, home
  for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.name == "eDP-1" then
      laptop = monitor
    elseif monitor.description == dell_description then
      dell = monitor
    elseif (monitor.description or ""):upper():find("GIGA", 1, true) then
      home = monitor
    end
  end

  -- Do not re-enable the panel when the lid/display toggle has disabled it.
  if not laptop then return end

  local width = math.floor(laptop.width / laptop.scale + 0.5)
  local height = math.floor(laptop.height / laptop.scale + 0.5)
  local x, y
  if dell then
    -- Laptop beside the Dell on the left, with bottom edges aligned.
    x = dell.x - width
    y = dell.y + math.floor(dell.height / dell.scale + 0.5) - height
  elseif home then
    -- Laptop below the Gigabyte, with right edges aligned.
    x = home.x + math.floor(home.width / home.scale + 0.5) - width
    y = home.y + math.floor(home.height / home.scale + 0.5)
  elseif #hl.get_monitors() == 1 then
    x, y = 0, 0
  else
    return
  end

  hl.monitor({ output = "eDP-1", mode = "preferred", position = string.format("%dx%d", x, y), scale = 1.25 })
end

-- Allow hotplug mode/scale changes to settle before reading display geometry.
local function schedule_layout()
  hl.timer(arrange_laptop, { timeout = 500, type = "oneshot" })
end

hl.on("monitor.added", schedule_layout)
hl.on("monitor.removed", schedule_layout)
hl.on("hyprland.start", schedule_layout)
schedule_layout()
