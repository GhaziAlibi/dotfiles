local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

function M.setup(config)
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
end

return M

