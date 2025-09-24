local awful = require("awful")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local naughty = require("naughty")
local HOME = os.getenv('HOME')

local popup = awful.popup {
   ontop = true,
   visible = true,
   shape = function(cr , width , height)
      gears.shape.rounded_rect(cr , width , height , 4)
   end,
   border_width = 1,
   border_color = bg.bg_focus,
   maximum_width = 600,
   offset = { y = 5 },
   widget = wibox.widget {

   }
}
return popup
