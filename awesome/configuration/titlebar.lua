
local dpi = require("beautiful.xresources").apply_dpi
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
       {
	     awful.titlebar.widget.closebutton    (c),
	     awful.titlebar.widget.floatingbutton(c),
	     awful.titlebar.widget.ontopbutton(c),
	     layout = wibox.layout.fixed.horizontal()
	},
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            wibox.container.margin(awful.widget.clienticon(c), dpi(5), dpi(5), dpi(5), dpi(5)),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal,

    }
end)
