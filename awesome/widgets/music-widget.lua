local awful = require("awful")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local naughty = require("naughty")
local HOME = os.getenv('HOME')

local ICON_DIR = HOME .. '/.config/awesome/widgets/icons/'

local GET_MPD_CMD = "mpc status"
local TOGGLE_MPD_CMD = "mpc toggle"
local PAUSE_MPD_CMD = "mpc pause"
local STOP_MPD_CMD = "mpc stop"
local NEXT_MPD_CMD = "mpc next"
local PREV_MPD_CMD = "mpc prev"

local popup = awful.popup {
    ontop = true,
    visible = false, -- should be hidden when created
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,
    border_width = 1,
    border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5 },
    widget = wibox.widget {
       text = 'MUSIC Widget',
       widget = wibox.widget.textbox
    }
}
-- local rows = { layout = wibox.layout.fixed.vertical }

-- for _, item in ipairs(menu_items) do

--    local row = wibox.widget {
--       {
-- 	 {
-- 	    image = ICON_DIR .. item.icon_name,
-- 	    forced_width = 16,
-- 	    forced_height = 16,
-- 	    widget = wibox.widget.imagebox
-- 	 },
-- 	 {
-- 	    text = item.name,
-- 	    widget = wibox.widget.textbox
-- 	 },
-- 	 spacing = 12,
-- 	 layout = wibox.layout.fixed.horizontal
--       },
--       margin = 8,
--       widget = wibox.container.margin
--    }
--     table.insert(rows, row)
-- end
-- bookmark_widget:buttons(
--     awful.util.table.join(
--         awful.button({}, 1, function()
--             if popup.visible then
--                 popup.visible = not popup.visible
--             else
--                  popup:move_next_to(mouse.current_widget_geometry)
--             end
--     end))
-- )
-- return bookmark_widget

return popup
