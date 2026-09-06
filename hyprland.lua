local active_border_color = { colors = { "rgba(E4AC8899)", "rgba(F2EEE555)" }, angle = 45 }
local inactive_border_color = "rgba(F2EEE522)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },

  decoration = {
    -- Broad soft corners and a faint rim of reflected light.
    rounding = 18,

    -- Terminals supply background-only alpha, preserving crisp text.
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 24,
      render_power = 3,
      color = "rgba(00000055)",
    },

    -- The frost itself.
    blur = {
      enabled = true,
      size = 10,
      passes = 3,
      noise = 0.012,
      contrast = 0.95,
      brightness = 1.0,
    },
  },
})

-- Keep Omarchy's app-specific opacity opt-outs (video, VMs, etc.).
o.window({ tag = "default-opacity" }, { opacity = "0.94 0.90" })
o.window("^(Alacritty|foot|footclient|kitty|com\\.mitchellh\\.ghostty|org\\.omarchy\\.agent)$", {
  opacity = "1.0 1.0",
})

-- Shell surfaces need their own blur rules in addition to decoration.blur.
-- Limit this to UI surfaces; the wallpaper and screen capture stay untouched.
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules
hl.layer_rule({
  match = {
    namespace = "^omarchy-(bar|menu|clipboard|emojis|keyboard-panel|notifications|osd|reminders|network-qr)$",
  },
  blur = true,
  blur_popups = true,
  -- Skip transparent margins and the menu's 0.18-alpha scrim.
  ignore_alpha = 0.2,
})
