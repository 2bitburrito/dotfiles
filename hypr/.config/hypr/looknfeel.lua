-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- No gaps between windows or borders.
    layout = "Dwindle",

    gaps_in = 2,
    gaps_out = 2,
    border_size = 1,

    -- Change to niri-like side-scrolling layout.
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    -- Use round window corners.
    rounding = 5,
    shadow = {
      enabled = true,
      range = 2,
      render_power = 3,
      color = "#1a1a1aee",
    },

    blur = {
      enabled = true,
      size = 2,
      passes = 2,
      special = true,
      brightness = 0.60,
      contrast = 0.75,
    },

    -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
    dim_inactive = true,
    dim_strength = 0.15,
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
