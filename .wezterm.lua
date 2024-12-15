-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Create a configuration table
local config = {}

-- Font settings
config.font = wezterm.font_with_fallback({
  "0xProto Nerd Font", -- Preferred Nerd Font
  "JetBrains Mono",    -- Fallback font
})
config.font_size = 14.0 -- Font size

-- Appearance settings
config.color_scheme = "Zenburn" -- Set color scheme
config.window_background_opacity = 0.9 -- Slight transparency
config.hide_tab_bar_if_only_one_tab = true -- Hide the tab bar if there's only one tab
config.window_decorations = "RESIZE" -- Basic window decorations

-- Set Bash as the default shell
config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login" }
-- config.default_prog = { "C:\\msys64\\usr\\bin\\zsh.exe" }

-- Key bindings (tmux-like setup)
config.keys = {
  -- Split the window vertically like tmux
  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitVertical,
  },
  
  -- Split the window horizontally like tmux
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitHorizontal,
  },

  -- Navigate between panes like tmux with Alt + Arrow keys
  {
    key = "LeftArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "RightArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    key = "UpArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "DownArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },

  -- Resize panes with Alt + Shift + Arrow keys (tmux-like resizing)
  {
    key = "LeftArrow",
    mods = "ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize({"Left", 5}),
  },
  {
    key = "RightArrow",
    mods = "ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize({"Right", 5}),
  },
  {
    key = "UpArrow",
    mods = "ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize({"Up", 5}),
  },
  {
    key = "DownArrow",
    mods = "ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize({"Down", 5}),
  },

  -- Toggle between tabs (like tmux window switching)

  -- Toggle opacity with CTRL+ALT+O
  {
    key = "O",
    mods = "CTRL|ALT",
    action = wezterm.action_callback(function(window, _)
      local overrides = window:get_config_overrides() or {}
      if overrides.window_background_opacity == 1.0 then
        overrides.window_background_opacity = 0.9
      else
        overrides.window_background_opacity = 1.0
      end
      window:set_config_overrides(overrides)
    end),
  },

  -- Close current pane (similar to tmux's kill-pane)
  {
    key = "X",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane({confirm = true}),
  },

  -- Create new tab (similar to tmux's new-window)
  {
    key = 'M',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

-- Return the configuration
return config
