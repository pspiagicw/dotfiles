local awful = require("awful")
local gfs = require("gears.filesystem")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local ICON = ''

local spotify_shell = awful.widget.prompt()

local w = wibox {
    bg = beautiful.bg_normal,
    border_width = 1,
    border_color = beautiful.border_focus,
    max_widget_size = 500,
    ontop = true,
    height = 50,
    width = 250,
    shape = function(cr, width, height)
        gears.shape.rounded_bar(cr, width, height, 3)
    end
}

w:setup {
    {
        {
            image = ICON,
            widget = wibox.widget.imagebox,
            resize = true
        },
        id = 'icon',
        -- top = 9,
        -- left = 10,
        layout = wibox.container.margin
    },
    {
        layout = wibox.container.margin,
        left = 10,
        spotify_shell,
    },
    id = 'left',
    layout = wibox.layout.fixed.horizontal
}

local function launch()
    w.visible = true

    awful.placement.top(w, { margins = {top = 50}, parent = awful.screen.focused()})
    awful.prompt.run{
        prompt = "<b> Shell </b>: ",
        bg_cursor = beautiful.fg_focus,
        textbox = spotify_shell.widget,
        history_path = gfs.get_dir('cache') .. '/shell_history',
        exe_callback = function(input_text)
            if not input_text or #input_text == 0 then return end
            awful.spawn(input_text)
        end,
        done_callback = function()
            w.visible = false
        end
    }
end

return {
    launch = launch
}
