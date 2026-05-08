local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config = {
  default_cursor_style = "BlinkingUnderline",
  automatically_reload_config = true,
  window_close_confirmation = "NeverPrompt",
  adjust_window_size_when_changing_font_size = false,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  use_resize_increments = false,
  window_decorations = "RESIZE",
  check_for_updates = false,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  enable_wayland = true,
  cursor_blink_rate = 400,
  font_size = 11.5,
  font = wezterm.font("JetBrains Mono"),
  enable_tab_bar = false,

  window_padding = {
    left = 3,
    right = 3,
    top = 0,
    bottom = 0,
  },

  background = nil,

  -- ATALHOS
  keys = {
    -- SPLITS
    {
      key = "|",
      mods = "CTRL|SHIFT",
      action = act.SplitHorizontal({
        domain = "CurrentPaneDomain",
      }),
    },

    {
      key = "-",
      mods = "CTRL|SHIFT",
      action = act.SplitVertical({
        domain = "CurrentPaneDomain",
      }),
    },

    -- RESIZE DOS PANES
    {
      key = "h",
      mods = "CTRL|SHIFT",
      action = act.AdjustPaneSize({ "Left", 3 }),
    },
    {
      key = "l",
      mods = "CTRL|SHIFT",
      action = act.AdjustPaneSize({ "Right", 3 }),
    },
    {
      key = "k",
      mods = "CTRL|SHIFT",
      action = act.AdjustPaneSize({ "Up", 3 }),
    },
    {
      key = "j",
      mods = "CTRL|SHIFT",
      action = act.AdjustPaneSize({ "Down", 3 }),
    },
  },

  -- hyperlinks
  hyperlink_rules = {
    {
      regex = "\\((\\w+://\\S+)\\)",
      format = "$1",
      highlight = 1,
    },
    {
      regex = "\\[(\\w+://\\S+)\\]",
      format = "$1",
      highlight = 1,
    },
    {
      regex = "\\{(\\w+://\\S+)\\}",
      format = "$1",
      highlight = 1,
    },
    {
      regex = "<(\\w+://\\S+)>",
      format = "$1",
      highlight = 1,
    },
    {
      regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
      format = "$1",
      highlight = 1,
    },
    {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
    },
  },
}
return config