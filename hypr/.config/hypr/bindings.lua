-- Personal keybinding overrides.
-- Ported from the pre-Quattro ~/.config/hypr/bindings.conf, which Omarchy 4 no
-- longer sources. Loaded after Omarchy's defaults, so anything here wins.
--
-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- "Hyper" chord ($m in the old config: SHIFT + CTRL + ALT). Used for window
-- management instead of Omarchy's SUPER-based motion bindings.
local hyper = "CTRL + ALT + SHIFT"
-- $sm in the old config: SUPER + hyper.
local super_hyper = "SUPER + CTRL + ALT + SHIFT"

-- Move focus (hyper + h/j/k/l).
o.bind(hyper .. " + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind(hyper .. " + L", "Focus right", hl.dsp.focus({ direction = "r" }))
o.bind(hyper .. " + K", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind(hyper .. " + J", "Focus down", hl.dsp.focus({ direction = "d" }))

-- Full window (hyper + f). Maximized, not true fullscreen: keeps bar/gaps/borders,
-- just fills the usable area (same mode as Omarchy's own SUPER + ALT + F).
o.bind(hyper .. " + F", "Full window", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Move window (super + hyper + h/j/k/l).
o.bind(super_hyper .. " + H", "Move window left", hl.dsp.window.move({ direction = "l" }))
o.bind(super_hyper .. " + L", "Move window right", hl.dsp.window.move({ direction = "r" }))
o.bind(super_hyper .. " + K", "Move window up", hl.dsp.window.move({ direction = "u" }))
o.bind(super_hyper .. " + J", "Move window down", hl.dsp.window.move({ direction = "d" }))

-- Resize active window (hyper + "-" / "=", i.e. code:20 / code:21).
o.bind(hyper .. " + code:20", "Expand window left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
o.bind(hyper .. " + code:21", "Shrink window left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))

-- Workspaces (hyper + 1..0 -> code:10..19).
for ws = 1, 10 do
  local key = "code:" .. tostring(ws + 9)
  o.bind(hyper .. " + " .. key, "Switch to workspace " .. ws, hl.dsp.focus({ workspace = tostring(ws) }))
  o.bind(super_hyper .. " + " .. key, "Move window to workspace " .. ws, hl.dsp.window.move({ workspace = tostring(ws) }))
end

-- Extra terminal launcher (hyper + RETURN). Omarchy keeps SUPER + RETURN.
o.bind(hyper .. " + RETURN", "Terminal", { omarchy = "terminal" })

-- Dedicated "T" workspace (hyper + T): switch to workspace 5, launching a
-- tmux terminal there first if it's empty. Workspace 5 (not a named
-- workspace) so it still shows up in the bar's workspace widget. Makes tmux
-- the default terminal workflow; the opposite of SUPER + ALT + RETURN, which
-- now opens a plain terminal in place (see below).
o.bind(hyper .. " + T", "Terminal workspace (tmux)", function()
  hl.dispatch(hl.dsp.focus({ workspace = "5" }))
  local windows = hl.get_workspace_windows("5")
  if not windows or #windows == 0 then
    hl.exec_cmd("omarchy-launch-terminal-tmux")
  end
end)

-- SUPER + ALT + RETURN was Omarchy's tmux terminal launcher; swap it to a
-- plain terminal now that hyper + T owns the tmux workflow.
hl.unbind("SUPER + ALT + RETURN") -- was: Tmux (terminal-tmux)
o.bind("SUPER + ALT + RETURN", "Terminal", { omarchy = "terminal" })

-- btop on SUPER + SHIFT + T (Omarchy's own btop binding is SUPER + CTRL + T).
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- Overrides of Omarchy defaults -- unbind first, then rebind.
hl.unbind("SUPER + O") -- was: Pop window out (float & pin)
o.bind(hyper .. " + O", "Pop window out (float & pin)", "omarchy-hyprland-window-pop")

hl.unbind("SUPER + SHIFT + W") -- was: Omawrite
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })

hl.unbind("SUPER + SHIFT + SLASH") -- was: 1Password
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "bitwarden" })


hl.unbind("SUPER + T")
o.bind(hyper .. " + COMMA", "Toggle tiling", hl.dsp.window.float({ action = "toggle" }))



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
o.bind(hyper .. " + V", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

-- Emoji picker (Omarchy's default lives on SUPER + CTRL + E; add it on hyper too).
o.bind(hyper .. " + E", "Emojis", "omarchy-shell shell toggle omarchy.emojis")
