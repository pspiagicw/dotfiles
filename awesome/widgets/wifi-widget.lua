local awful = require("awful")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local naughty = require("naughty")


-- local wifiwidget = watch("get-wifi-name" , 15 , function(widget , stdout)
-- 			    widget:set_text(stdout.gmatch("[ \n]"))
-- 			    return
-- end)
local wifiwidget = awful.widget.watch("get-wifi-name", 60)
return wifiwidget

-- local wifiwidget = lain.widget.net{
--    settings = function()
--       widget:set_markup(net_now.sent)
--    end
-- }
-- return wifiwidget
