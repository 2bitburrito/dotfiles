-- Personal keybinding overrides.
-- Ported from the pre-Quattro ~/.config/hypr/bindings.conf, which Omarchy 4 no
-- longer sources. Loaded after Omarchy's defaults, so anything here wins.
-- Defaults live at: "/usr/share/omarchy/default/hypr/bindings/"

hl.unbind("SUPER + J") -- Was: Toggle window split
hl.unbind("SUPER + K") -- Was: Keybindings
hl.unbind("SUPER + L") -- Was: Toggle workspace layout

o.bind("SUPER + I", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + N", "Focus next monitor", hl.dsp.focus({ monitor = "+1" }))

-- Keep workspace cycling on the focused monitor. Number shortcuts still jump
-- directly to globally numbered workspaces, including on another monitor.
local function cycle_monitor_workspace(step)
  local monitor = hl.get_active_monitor()
  if not monitor then return end
  local workspaces = {}
  for _, workspace in ipairs(hl.get_workspaces()) do
    if not workspace.special and workspace.monitor and workspace.monitor.id == monitor.id then
      table.insert(workspaces, workspace)
    end
  end
  table.sort(workspaces, function(a, b) return a.id < b.id end)
  if #workspaces < 2 then return end
  local current = hl.get_active_workspace(monitor)
  for index, workspace in ipairs(workspaces) do
    if current and workspace.id == current.id then
      local target = workspaces[((index - 1 + step) % #workspaces) + 1]
      hl.dispatch(hl.dsp.focus({ workspace = tostring(target.id) }))
      return
    end
  end
end

hl.unbind("SUPER + TAB") -- Was: Next workspace (across all monitors)
hl.unbind("SUPER + SHIFT + TAB") -- Was: Previous workspace (across all monitors)
o.bind("SUPER + TAB", "Next workspace on this monitor", function() cycle_monitor_workspace(1) end)
o.bind("SUPER + SHIFT + TAB", "Previous workspace on this monitor", function() cycle_monitor_workspace(-1) end)

-- Remove the arrow-key versions of directional bindings below.
for _, key in ipairs({ "LEFT", "RIGHT", "UP", "DOWN" }) do
  hl.unbind("SUPER + " .. key)
  hl.unbind("SUPER + SHIFT + " .. key)
  hl.unbind("SUPER + SHIFT + ALT + " .. key)
  hl.unbind("SUPER + ALT + " .. key)
end
hl.unbind("SUPER + CTRL + LEFT")
hl.unbind("SUPER + CTRL + RIGHT")

-- Move focus (SUPER + h/j/k/l).
o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + K", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + J", "Focus down", hl.dsp.focus({ direction = "d" }))

-- Full window (SUPER + F). Maximized, not true fullscreen: keeps bar/gaps/borders,
-- just fills the usable area (same mode as Omarchy's own SUPER + ALT + F).
hl.unbind("SUPER + F") -- Was: Full screen
o.bind("SUPER + F", "Full window", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Move window (SUPER + SHIFT + h/j/k/l).
o.bind("SUPER + SHIFT + H", "Move window left", hl.dsp.window.move({ direction = "l" }))
o.bind("SUPER + SHIFT + L", "Move window right", hl.dsp.window.move({ direction = "r" }))
o.bind("SUPER + SHIFT + K", "Move window up", hl.dsp.window.move({ direction = "u" }))
o.bind("SUPER + SHIFT + J", "Move window down", hl.dsp.window.move({ direction = "d" }))

-- Move workspace between monitors (SUPER + SHIFT + ALT + h/j/k/l).
o.bind("SUPER + SHIFT + ALT + H", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))
o.bind("SUPER + SHIFT + ALT + L", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))
o.bind("SUPER + SHIFT + ALT + K", "Move workspace to up monitor", hl.dsp.workspace.move({ monitor = "u" }))
o.bind("SUPER + SHIFT + ALT + J", "Move workspace to down monitor", hl.dsp.workspace.move({ monitor = "d" }))

-- Vim-style group movement and navigation.
hl.unbind("SUPER + ALT + K") -- Was: Tmux keybindings
o.bind("SUPER + ALT + H", "Move window to group on left", hl.dsp.window.move({ into_group = "l" }))
o.bind("SUPER + ALT + L", "Move window to group on right", hl.dsp.window.move({ into_group = "r" }))
o.bind("SUPER + ALT + K", "Move window to group on top", hl.dsp.window.move({ into_group = "u" }))
o.bind("SUPER + ALT + J", "Move window to group on bottom", hl.dsp.window.move({ into_group = "d" }))

hl.unbind("SUPER + CTRL + H") -- Was: Hardware menu
hl.unbind("SUPER + CTRL + L") -- Was: Lock system
o.bind("SUPER + CTRL + H", "Move grouped window focus left", hl.dsp.group.prev())
o.bind("SUPER + CTRL + L", "Move grouped window focus right", hl.dsp.group.next())
o.bind("SUPER + CTRL + ALT + H", "Hardware menu", "omarchy-menu toggle hardware")
o.bind("SUPER + CTRL + ALT + L", "Lock system", "omarchy-system-lock")
-- Dedicated T workspace (SUPER + T): switch to workspace 5, launching a
-- tmux terminal there first if it's empty. Workspace 5 (not a named
-- workspace) so it still shows up in the bar's workspace widget. Makes tmux
-- the default terminal workflow; the opposite of SUPER + ALT + RETURN, which
-- now opens a plain terminal in place (see below).
hl.unbind("SUPER + T") -- Was: Toggle window floating/tiling
o.bind("SUPER + T", "Terminal workspace (tmux)", function()
  hl.dispatch(hl.dsp.focus({ workspace = "5" }))
  local windows = hl.get_workspace_windows("5")
  if not windows or #windows == 0 then
    hl.exec_cmd("omarchy-launch-terminal-tmux")
  end
end)

-- SUPER + ALT + RETURN was Omarchy's tmux terminal launcher; swap it to a
-- plain terminal now that SUPER + T owns the tmux workflow.
hl.unbind("SUPER + ALT + RETURN") -- was: Tmux (terminal-tmux)
o.bind("SUPER + ALT + RETURN", "Terminal", { omarchy = "terminal" })

-- btop on SUPER + SHIFT + T (Omarchy's own btop binding is SUPER + CTRL + T).
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- Overrides of Omarchy defaults -- unbind first, then rebind.
hl.unbind("SUPER + O") -- was: Pop window out (float & pin)
o.bind("SUPER + O", "Pop window out (float & pin)", "omarchy-hyprland-window-pop")

hl.unbind("SUPER + SLASH") -- was: change display zoom
o.bind("SUPER + SLASH", "Toggle tiling", hl.dsp.window.float({ action = "toggle" }))
-- SUPER + W: mac-style "close tab, not the window" for browsers.
-- Omarchy tags every browser window with chromium-based-browser or
-- firefox-based-browser (see /usr/share/omarchy/default/hypr/apps/browser.lua).
-- On a browser, forward CTRL+W (the browser's own close-tab shortcut, same on
-- both families) instead of killactive; every other app keeps the default
-- close-window behavior.
hl.unbind("SUPER + W") -- was: Close window (killactive), even on browsers

local function active_window_is_browser()
  local window = hl.get_active_window()
  if not window then
    return false
  end

  for _, tag in ipairs(window.tags or {}) do
    local base = tag:gsub("%*$", "")
    if base == "chromium-based-browser" or base == "firefox-based-browser" then
      return true
    end
  end

  return false
end

o.bind("SUPER + W", "Close tab (browser) / window", function()
  if active_window_is_browser() then
    hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL", key = "W", state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL", key = "W", state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  else
    hl.dispatch(hl.dsp.window.close())
  end
end)

-- Clipboard Manager
o.bind("SUPER + SHIFT + V", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

o.bind("SUPER + E", "Emojis", "omarchy-shell shell toggle omarchy.emojis")
-- Emoji picker (Omarchy's default lives on SUPER + CTRL + E; add it on SUPER too).
