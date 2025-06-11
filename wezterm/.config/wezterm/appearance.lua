local wezterm = require 'wezterm'

local M = {}

function M.setup(config)
  -- Font configuration
  config.font = wezterm.font_with_fallback {
    {
      family = 'MesloLGS NF',
      -- Enable ligatures and other OpenType features
      harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
    },
    -- Fallback fonts if needed
    'Noto Color Emoji',
  }

  -- Font size (adjust to your preference)
  config.font_size = 12.0

  -- Line height
  config.line_height = 1.1

  -- Terminal padding
  config.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4,
  }

  -- Color scheme
  config.color_scheme = 'Tokyo Night'

  -- Window transparency (0.0 is fully transparent, 1.0 is opaque)
  config.window_background_opacity = 1.0

  -- Use GPU rendering
  config.front_end = 'WebGpu'

  -- Enable scroll bar
  config.enable_scroll_bar = true

  -- Window decorations - 'TITLE', 'RESIZE', 'NONE'
  config.window_decorations = 'NONE'

  -- Hyperlink settings
  config.hyperlink_rules = {
    -- Default hyperlink rules
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },
    -- File paths
    {
      regex = [[\b(file://|/[\w.-]+/[\w.-/]+)\b]],
      format = '$0',
    },
    -- IP addresses
    {
      regex = [[\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b]],
      format = '$0',
    },
  }

  -- Smooth scrolling
  config.scroll_to_bottom_on_input = true

  -- Animation effects
  config.animation_fps = 60
  config.enable_kitty_keyboard = true
  config.enable_kitty_graphics = true

  -- Disable audio bell, use visual bell instead
  config.audible_bell = "Disabled"
  config.visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = 'CursorColor',
  }

  -- Scrollback
  config.scrollback_lines = 10000
end

return M

