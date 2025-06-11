local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

-- Use the config_builder which will help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

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

-- Tab bar settings
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- Window transparency (0.0 is fully transparent, 1.0 is opaque)
config.window_background_opacity = 1.0

-- Use GPU rendering
config.front_end = 'WebGpu'

-- Enable scroll bar
config.enable_scroll_bar = true

-- ======================================
-- 1. Custom key bindings
-- ======================================

config.keys = {
  -- Tabs management
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'DefaultDomain' },
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true } },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  
  -- Splits management
  { key = '|', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '_', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  
  -- Pane navigation
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down' },
  
  -- Font size
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  
  -- Paste from clipboard
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  
  -- Copy to clipboard
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  
  -- Quick reload config
  { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
  
  -- Open URL under cursor
  { key = 'u', mods = 'CTRL|SHIFT', action = act.OpenLinkAtMouseCursor },
}

-- ======================================
-- 2. Cursor customization
-- ======================================

-- Cursor style: 'SteadyBlock', 'BlinkingBlock', 'SteadyUnderline', 'BlinkingUnderline', 'SteadyBar', 'BlinkingBar'
config.default_cursor_style = 'BlinkingBar'

-- Cursor blink rate (in milliseconds)
config.cursor_blink_rate = 500

-- Cursor thickness (for bar and underline styles)
config.cursor_thickness = 2

-- ======================================
-- 3. Window and tab management
-- ======================================

-- Set default working directory
-- Uncomment and change to your preferred starting directory
-- config.default_cwd = '/home/ghazi/projects'

-- Window title format
config.window_frame = {
  font = wezterm.font { family = 'MesloLGS NF', weight = 'Bold' },
  font_size = 12.0,
  active_titlebar_bg = '#2D4F67',
  active_titlebar_fg = '#FFFFFF',
  inactive_titlebar_bg = '#1E2C35',
  inactive_titlebar_fg = '#AAAAAA',
  border_left_width = '0.5cell',
  border_right_width = '0.5cell',
  border_bottom_height = '0.25cell',
  border_top_height = '0.25cell',
  border_left_color = '#3B5E77',
  border_right_color = '#3B5E77',
  border_bottom_color = '#3B5E77',
  border_top_color = '#3B5E77',
}

-- Tab title format (shows current command)
config.tab_max_width = 25
config.show_tab_index_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

-- Initial window size and position
config.initial_cols = 120
config.initial_rows = 35

-- ======================================
-- 4. Advanced visual settings
-- ======================================

-- Window decorations - 'TITLE', 'RESIZE', 'NONE'
-- Ensure window decorations include title bar and resize handles
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

-- ======================================
-- 5. Additional appearance tweaks
-- ======================================

-- Smooth scrolling
config.enable_scroll_bar = true
config.scroll_to_bottom_on_input = true

-- Enable GPU based rendering
config.front_end = 'WebGpu'

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

return config

