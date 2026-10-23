-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Restore plain Caps Lock. Omarchy's default remaps it to a compose key
-- (compose:caps) and moves actual caps-toggling to both Shift keys at once
-- (shift:both_capslock_cancel) -- see /usr/share/omarchy/default/hypr/input.lua.
-- Setting kb_options here overrides that default entirely, so Caps Lock just
-- toggles caps again.
hl.config({
  input = {
    kb_options = "",
  },
})

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- Change speed of keyboard repeat.
    repeat_rate = 35,
    repeat_delay = 150,

    -- Start with numlock on by default.
    numlock_by_default = true,
    --
    -- Increase sensitivity for mouse/trackpad (default: 0).
    sensitivity = 0,
    --
    -- Turn off mouse acceleration (default: adaptive).
    --     accel_profile = "flat",
    --
    --
    --
    -- Scroll fasctor for mouse wheel:
    scroll_factor = 0.6,

    touchpad = {
      scroll_factor = 0.3,
      drag_3fg = 1,
    }
    -- Enable the touchpad while typing.
    --       disable_while_typing = false,
    --
    -- Left-click-and-drag with three fingers.
    --     },
  },
})

hl.config({
  cursor = {
    -- Mouse cursor jumping when focus changes
    no_warps = false,
  }
})

-- App-specific touchpad scroll speeds.
-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })
