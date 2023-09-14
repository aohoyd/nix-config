local wezterm = require("wezterm")
local scheme = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]

return {
    check_for_updates = false,
    color_scheme = "Catppuccin Mocha",
    inactive_pane_hsb = {
        hue = 1.0,
        saturation = 1.0,
        brightness = 1.0,
    },
    -- default_prog = { '/bin/bash', '-l' },
    -- font = wezterm.font 'Ubuntu Mono derivative Powerline',
    -- font = wezterm.font 'UbuntuMono Nerd Font',
    font = wezterm.font 'Berkeley Mono NF',
    font_size = 19.0,
    launch_menu = {},
    -- leader = { key="a", mods="CTRL" },
    disable_default_key_bindings = true,
    keys = {
        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        -- { key = "a", mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
        { key = "-", mods = "CMD",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
        { key = "=", mods = "CMD",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        { key = "z", mods = "CMD",       action="TogglePaneZoomState" },
        { key = "t", mods = "CMD",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
        { key = "h", mods = "CMD",       action=wezterm.action{ActivatePaneDirection="Left"}},
        { key = "j", mods = "CMD",       action=wezterm.action{ActivatePaneDirection="Down"}},
        { key = "k", mods = "CMD",       action=wezterm.action{ActivatePaneDirection="Up"}},
        { key = "l", mods = "CMD",       action=wezterm.action{ActivatePaneDirection="Right"}},
        { key = "H", mods = "CMD|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
        { key = "J", mods = "CMD|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
        { key = "K", mods = "CMD|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
        { key = "L", mods = "CMD|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
        { key = "1", mods = "CMD",       action=wezterm.action{ActivateTab=0}},
        { key = "2", mods = "CMD",       action=wezterm.action{ActivateTab=1}},
        { key = "3", mods = "CMD",       action=wezterm.action{ActivateTab=2}},
        { key = "4", mods = "CMD",       action=wezterm.action{ActivateTab=3}},
        { key = "5", mods = "CMD",       action=wezterm.action{ActivateTab=4}},
        { key = "6", mods = "CMD",       action=wezterm.action{ActivateTab=5}},
        { key = "7", mods = "CMD",       action=wezterm.action{ActivateTab=6}},
        { key = "8", mods = "CMD",       action=wezterm.action{ActivateTab=7}},
        { key = "9", mods = "CMD",       action=wezterm.action{ActivateTab=8}},
        { key = "x", mods = "CMD",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
        { key = "w", mods = "CMD",       action=wezterm.action{CloseCurrentTab={confirm=true}}},

        { key = "n", mods="SHIFT|CTRL", action="ToggleFullScreen" },
        { key = "v",   mods="CMD",      action=wezterm.action.PasteFrom "Clipboard" },
        { key = "c",   mods="CMD",      action=wezterm.action.CopyTo "Clipboard" },
        { key = "/",   mods="CMD",      action="QuickSelect" },
        { key = "[",   mods="CMD",      action="ActivateCopyMode" },
        { key = "f",   mods="CMD",      action=wezterm.action {Search = {CaseInSensitiveString = ""}} },
    },
    set_environment_variables = {},

    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,

    colors = {
      tab_bar = {
        background = scheme.background,
        new_tab = { bg_color = "#2e3440", fg_color = scheme.ansi[8], intensity = "Bold" },
        new_tab_hover = { bg_color = scheme.ansi[1], fg_color = scheme.brights[8], intensity = "Bold" },
        -- format-tab-title
        -- active_tab = { bg_color = "#121212", fg_color = "#FCE8C3" },
        -- inactive_tab = { bg_color = scheme.background, fg_color = "#FCE8C3" },
        -- inactive_tab_hover = { bg_color = scheme.ansi[1], fg_color = "#FCE8C3" },
      },
    },

    launch_menu = {
        { label = "bash", args = {"bash", "-l"} },
        { label = "fish", args = {"fish", "-l"} },
    },
}