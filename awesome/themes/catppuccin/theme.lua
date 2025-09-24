-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

local themes_path = "/home/pspiagicw/.config/awesome/themes/catppuccin/"
local dpi = require("beautiful.xresources").apply_dpi
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. "wallpaper.png"
-- }}}

theme.cpu_icon = themes_path .. "icons/cpu.png"
theme.bat_icon = themes_path .. "icons/bat.png"
theme.mem_icon = themes_path .. "icons/mem.png"
theme.mpd_icon = themes_path .. "icons/note.png"
theme.clock_icon = themes_path .. "icons/clock.png"
theme.wifi_icon = themes_path .. "icons/wifi.png"
-- {{{ Styles
theme.font      = "Iosevka Medium 8"
theme.dmenu_font = "JetBrains Mono:size=8"
-- theme.dmenu_selected_bg = "#f8bd96"
-- theme.dmenu_selected_fg = "#1e1e2e"
-- theme.dmenu_normal_bg = "#1e1e2e"
-- theme.dmenu_normal_fg = "#d9e0ee"
theme.widget_font = "Iosevka Medium 8"
theme.background = '#000000' .. '66'
theme.gray   = "#94928F"
theme.orange = "#f8bd96"
theme.label = "#f28fad"
theme.high_color = "#e8a2af"
theme.low_color = "#abe9b3"
theme.medium_color = "#f8bd96"
theme.batwidget_label_color = "#b5e8e0"
theme.memwidget_label_color = "#fae3b0"
theme.cpuwidget_label_color = "#f5c2e7"
theme.mpdwidget_label_color = "#96cdf8"
theme.clockwidget_label_color = "#f8bd96"

-- {{{ Colors
theme.fg_normal  = "#abe9b3"
theme.fg_focus   = "#f8bd96"
theme.fg_urgent  = "#f28fad"
theme.bg_normal  = "#1e1e2e"
theme.bg_focus   = "#1e1e2e"
theme.bg_urgent  = "#f28fad"
theme.bg_systray = theme.bg_normal
-- }}}

theme.transparent = '#2e3440'
theme.titlebar_bg_focus = "#1d2021"
theme.titlebar_fg_focus = "#d3869b"
theme.titlebar_fg_normal = "#d3869b"
theme.titlebar_bg_normal = "#1d2021"

-- theme.bg_systray = theme.background
theme.systray_icon_spacing = dpi(16)
-- {{{ Borders
theme.useless_gap   = dpi(5)
theme.border_width  = dpi(1)
theme.border_normal = "#6e6c7e"
theme.border_focus  = "#f8bd96"
theme.border_marked = "#fb4934"
theme.border_radius = dpi(10)
-- }}}

theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_font_focus = "Iosevka Medium 7"

-- {{{ Titlebars
theme.notification_position = 'top_right'
theme.notification_bg = "#f2cdcd"
theme.notification_fg = "#1e1e2e"

theme.notification_margin = dpi(10)
theme.notification_border_width = dpi(10)
theme.notification_border_radius = 0
theme.notification_border_color = "#f8bd96"
theme.notification_spacing = dpi(10)
-- theme.notification_shape = gears.shape.rounted_rect
-- theme.notification_icon_resize_strategy = 'center'
-- theme.notification_icon_size = dpi(32)


theme.hotkeys_font = 'Iosevka'
-- theme.hotkeys_description_font   = 'Iosevka'
-- theme.hotkeys_bg = "#1e1e2e"
-- theme.hotkeys_label_fg = "#fs8fad"
theme.hotkeys_modifiers_fg = "#F28FAD"
-- theme.hotkeys_label_bg = "#F2CDCD"
-- theme.hotkeys_group_margin = dpi(20)


theme.menu_font = 'Cascadia Mono 9'
theme.menu_submenu = ':: ' -- ➤
-- theme.menu_submenu_icon = themes_path .. 'arrow.png' -- ➤

theme.menu_height = 32
theme.menu_width = 200
-- theme.menu_border_width = dpi(30)
theme.menu_border_color = "#1e1e2e"
theme.menu_border_width = dpi(0.5)
theme.menu_bg_focus = "#1e1e2e"
theme.menu_fg_focus = "#F28FAD"
theme.menu_bg_normal = "#1e1e2e"
theme.menu_fg_normal = "#F5E0DC"

-- theme.menu_bg_normal =  theme.background:sub(1,7) .. '33'
-- theme.menu_fg_normal = '#ffffff'
-- theme.menu_fg_focus = '#ffffff'
-- theme.menu_border_color = theme.background:sub(1,7) .. '5C'
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

theme.taglist_spacing = 4
theme.taglist_font = 'JetBrains Mono 7'
theme.taglist_bg_focus = "#f28fad"
theme.taglist_fg_focus = "#282828"
theme.taglist_bg_empty = "#575268"
theme.taglist_fg_empty = "#f5e0dc"
theme.taglist_bg_occupied = "#abe9b3"
theme.taglist_fg_occupied = "#282828"
theme.taglist_shape = gears.shape.circle


theme.tasklist_font = "Iosevka 7"
-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_height = dpi(15)
-- theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = themes_path .. "taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "awesome-icon.svg"
-- theme.menu_submenu_icon      = themes_path .. "default/submenu.png"
-- }}}

-- {{{ Layout
-- theme.layout_tile       = themes_path .. "layouts/tile.svg"
-- theme.layout_tileleft   = themes_path .. "layouts/tileleft.png"
-- theme.layout_tilebottom = themes_path .. "layouts/tilebottom.png"
-- theme.layout_tiletop    = themes_path .. "layouts/tiletop.png"
-- theme.layout_fairv      = themes_path .. "layouts/fairv.png"
-- theme.layout_fairh      = themes_path .. "layouts/fairh.png"
-- theme.layout_spiral     = themes_path .. "layouts/spiral.png"
-- theme.layout_dwindle    = themes_path .. "layouts/dwindle.png"
-- theme.layout_max        = themes_path .. "layouts/max.svg"
-- theme.layout_fullscreen = themes_path .. "layouts/fullscreen.png"
-- theme.layout_magnifier  = themes_path .. "layouts/magnifier.png"
-- theme.layout_floating   = themes_path .. "layouts/floating.svg"
-- theme.layout_cornernw   = themes_path .. "layouts/cornernw.png"
-- theme.layout_cornerne   = themes_path .. "layouts/cornerne.png"
-- theme.layout_cornersw   = themes_path .. "layouts/cornersw.png"
-- theme.layout_cornerse   = themes_path .. "layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "titlebar/close_normal.png"

-- theme.titlebar_minimize_button_normal = themes_path .. "titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_focus  = themes_path .. "titlebar/minimize_focus.png"

-- theme.titlebar_ontop_button_focus_active  = themes_path .. "titlebar/ontop_focus_active.png"
-- theme.titlebar_ontop_button_normal_active = themes_path .. "titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_inactive  = themes_path .. "titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_inactive = themes_path .. "titlebar/ontop_normal_inactive.png"

theme.titlebar_ontop_button_focus_active = themes_path .. "titlebar/ontop_focus.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "titlebar/ontop_normal.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "titlebar/ontop_focus.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "titlebar/ontop_normal.png"
-- theme.titlebar_sticky_button_focus_active  = themes_path .. "titlebar/sticky_focus_active.png"
-- theme.titlebar_sticky_button_normal_active = themes_path .. "titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_inactive  = themes_path .. "titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_inactive = themes_path .. "titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active = themes_path .. "titlebar/floating_focus.png"
theme.titlebar_floating_button_normal_active = themes_path .. "titlebar/floating_normal.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "titlebar/floating_focus.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "titlebar/floating_normal.png"

-- theme.titlebar_maximized_button_focus_active  = themes_path .. "titlebar/maximized_focus_active.png"
-- theme.titlebar_maximized_button_normal_active = themes_path .. "titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_inactive  = themes_path .. "titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_inactive = themes_path .. "titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

theme.wibar_height = dpi(25)
theme.wibar_bg = theme.bg_normal
theme.wibar_border_width = 5
theme.wibar_border_color = "#00000000"
-- theme.wibar_border_color = "#6a537f"



return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
