local M = {}

function M.setup(config)
  -- Cursor style: 'SteadyBlock', 'BlinkingBlock', 'SteadyUnderline', 'BlinkingUnderline', 'SteadyBar', 'BlinkingBar'
  config.default_cursor_style = 'BlinkingBar'

  -- Cursor blink rate (in milliseconds)
  config.cursor_blink_rate = 500

  -- Cursor thickness (for bar and underline styles)
  config.cursor_thickness = 2
end

return M

