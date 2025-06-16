local wezterm = require 'wezterm'

local M = {}

function M.setup(config)
  -- Tab bar settings
  config.use_fancy_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = false

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
end

return M

