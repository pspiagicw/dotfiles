-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

local themes_path = "/home/pspiagicw/.config/awesome/themes/dracula/"
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
theme.font      = "Iosevka 8"
theme.dmenu_font = "Iosevka:size=9"
theme.dmenu_selected_fg = "#000000"
theme.dmenu_selected_bg = "#ffb86c"
theme.dmenu_normal_bg = "#282a36"
theme.dmenu_normal_fg = "#f8f8f2"
theme.widget_font = "Iosevka 8"
theme.background = '#000000' .. '66'
theme.gray   = "#94928F"
theme.orange = "#ffb86c"
theme.label = "#bd93f9"
theme.high_color = "#ff5555"
theme.low_color = "#50fa7b"
theme.medium_color = "#ffb86c"
theme.batwidget_label_color = "#bd93f9"
theme.memwidget_label_color = "#f1fa8c"
theme.cpuwidget_label_color = "#ff79c6"
theme.mpdwidget_label_color = "#8be9fd"
theme.clockwidget_label_color = "#ffb86c"

-- {{{ Colors
theme.fg_normal  = "#bd93f9"
theme.fg_focus   = "#ffb86c"
theme.fg_urgent  = "#000000"
theme.bg_normal  = "#282a36"
theme.bg_focus   = "#44475a"
theme.bg_urgent  = "#ff5555"
theme.bg_systray = theme.bg_normal
-- }}}

theme.transparent = '#2e3440'
theme.titlebar_bg_focus = "#21222c"
theme.titlebar_fg_focus = "#bd93f9"
theme.titlebar_fg_normal = "#bd93f9"
theme.titlebar_bg_normal = "#21222c"

-- theme.bg_systray = theme.background
theme.systray_icon_spacing = dpi(16)
-- {{{ Borders
theme.useless_gap   = dpi(6)
theme.border_width  = dpi(1)
theme.border_normal = "#44475a"
theme.border_focus  = "#ffb86c"
theme.border_marked = "#ff5555"
theme.border_radius = dpi(10)
-- }}}

theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_font_focus = "Iosevka Medium 7"

-- {{{ Titlebars
theme.notification_position = 'top_right'
theme.notification_bg = "#bd93f9"
theme.notification_fg = "#000000"

theme.notification_margin = dpi(10)
theme.notification_border_width = dpi(0)
theme.notification_border_radius = dpi(10)
theme.notification_border_color = theme.notification_bg
theme.notification_spacing = dpi(10)
theme.notification_shape = gears.shape.rounded_rect
-- theme.notification_icon_resize_strategy = 'center'
-- theme.notification_icon_size = dpi(32)


theme.hotkeys_font = 'JetBrains Mono'
theme.hotkeys_description_font   = 'Iosevka'
-- theme.hotkeys_bg = "#2e3440"
-- theme.hotkeys_modifiers_fg = "#bf616a"
theme.hotkeys_group_margin = dpi(20)


theme.menu_font = 'JetBrains Mono 9'
theme.menu_submenu = '> ' -- ➤
-- theme.menu_submenu_icon = themes_path .. 'arrow.png' -- ➤

theme.menu_height = 32
theme.menu_width = 250
-- theme.menu_border_width = dpi(30)
theme.menu_border_color = "#44475a"
theme.menu_border_width = dpi(0.5)
theme.menu_bg_focus = "#282a36"
theme.menu_fg_focus = "#bd93f9"
theme.menu_bg_normal = "#282a36"
theme.menu_fg_normal = "#ffffff"

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
theme.taglist_bg_focus = "#ffb86c"
theme.taglist_fg_focus = "#000000"
theme.taglist_bg_empty = "#6272a4"
theme.taglist_fg_empty = "#000000"
theme.taglist_bg_occupied = "#bd93f9"
theme.taglist_fg_occupied = "#000000"
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
