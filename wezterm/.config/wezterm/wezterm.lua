-- WezTerm Configuration
-- Main configuration file that imports modular components

local wezterm = require 'wezterm'

-- Import configuration modules
local appearance = require 'appearance'
local cursor = require 'cursor'
local keys = require 'keys'
local window = require 'window'

local config = {}

-- Use the config_builder which will help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Apply modular configurations
appearance.setup(config)
cursor.setup(config)
keys.setup(config)
window.setup(config)

return config

