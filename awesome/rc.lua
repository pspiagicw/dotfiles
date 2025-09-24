-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- Standard awesome library
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local awful = require("awful")
local scratch = require("scratch")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local lain          = require("lain")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local freedesktop   = require("freedesktop")
local markup = lain.util.markup
-- local wifiwidget = require("widgets.wifi-widget")

-- local revelation=require("revelation")
-- local layoutwidget = require("widgets.layout-widget")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
                    title = "Oops, there were errors during startup!",
                    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
                             -- Make sure we don't go into an endless error loop
                             if in_error then return end
                             in_error = true

                             naughty.notify({ preset = naughty.config.presets.critical,
                                              title = "Oops, an error happened!",
                                              text = tostring(err) })
                             in_error = false
   end)
end
-- }}}

current_theme="catppuccin"
-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/pspiagicw/.config/awesome/themes/" .. current_theme .. "/theme.lua")
-- local bling = require("bling")
-- bling.module.flash_focus.enable()
-- revelation.init({
--       tag_name = 'R',
-- })

-- bling.widget.tag_preview.enable {
--    show_client_content = false,  -- Whether or not to show the client content
--    x = 10,                       -- The x-coord of the popup
--    y = 10,                       -- The y-coord of the popup
--    scale = 0.25,                 -- The scale of the previews compared to the screen
--    honor_padding = false,        -- Honor padding when creating widget size
--    honor_workarea = false,       -- Honor work area when creating widget size
--    placement_fn = function(c)    -- Place the widget using awful.placement (this overrides x & y)
--       awful.placement.top_left(c, {
--                                   margins = {
--                                      top = 30,
--                                      left = 30
--                                   }
--       })
--    end,
--    background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget 
--       image = beautiful.wallpaper,
--       horizontal_fit_policy = "fit",
--       vertical_fit_policy   = "fit",
--       widget = wibox.widget.imagebox
--    }
-- }
local mpc_prompt = require("widgets.mpc-prompt")
local command_prompt = require("widgets.command-prompt")
-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = "emacsclient -c"
editor_cmd = terminal .. " -e " .. editor
browser = "qutebrowser"
-- dmenu_cmd = "dmenu_run -fn " .. "\"" .. beautiful.dmenu_font .. "\"" .. " -sf " .. "\"" .. beautiful.dmenu_selected_fg .. "\"" .. " -sb " .. "\"" .. beautiful.dmenu_selected_bg .. "\"" .. " -nb " .. "\"" .. beautiful.dmenu_normal_bg .. "\"" .. " -nf " .. "\"" .. beautiful.dmenu_normal_fg .. "\""

dmenu_cmd = "dmenu_run"
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

awful.mouse.snap.edge_enabled = false
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   -- awful.layout.suit.tile.left,
   -- awful.layout.suit.tile.bottom,
   -- awful.layout.suit.tile.top,
   awful.layout.suit.fair,
   awful.layout.suit.floating,
   awful.layout.suit.tile,
   -- awful.layout.suit.fair.horizontal,
   -- awful.layout.suit.spiral,
   -- awful.layout.suit.spiral.dwindle,
   -- awful.layout.suit.max,
   -- awful.layout.suit.max.fullscreen,
   -- awful.layout.suit.magnifier,
   -- awful.layout.suit.corner.nw,
   -- awful.layout.suit.corner.ne,
   -- awful.layout.suit.corner.sw,
   -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "Manual", terminal .. " -e man awesome" },
   { "Edit config", editor .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
   { "Quit", function() awesome.quit() end },
}
-- appmenu = {
--    { "Terminal" , {
--       { "cava" , function() awful.spawn("alacritty -t floater -e cava") end },
--       { "top" , function() awful.spawn("alacritty -t floater -e top") end },
--       { "btm" , function() awful.spawn("alacritty -t floater -e btm") end },
--       { "pulsemixer" , function() awful.spawn("alacritty -t floater -e pulsemixer") end },
--       { "mmtc" , function() awful.spawn("alacritty -t floater -e mmtc") end }

--    }},
--    { "LibreOffice" , function() awful.spawn("LibreOffice.AppImage") end },
--    { "GIMP" , function() awful.spawn("GIMP.AppImage") end },
--    { "KdenLive" , function() awful.spawn("KdenLive.AppImage") end },
--    { "Firefox" , function() awful.spawn("FireFox.AppImage") end },
--    { "Teams" , function() awful.spawn("teams") end },
-- }
-- configurationmenu = {
--    { "NVIDIA Settings" , function() awful.spawn("nvidia-settings") end},
--    { "GTK Settings" , function() awful.spawn("lxappearance") end },
--    { "Emacs Config" , editor .. " " .. "~/.config/emacs/emacs.org" },
--    { "Awesome Config" , editor .. " " .. "~/.config/awesome/rc.lua" },
--    { "Alacritty Config" , editor .. " " .. "~/.config/alacritty/alacritty.yml" },
--    { "Picom Config" , editor .. " " .. "~/.config/picom/picom.conf" },
--    { "QuteBrowser Config" , editor .. " " .. "~/.config/qutebrowser/config.py" },
--    { "Printer Config" , function() awful.spawn("system-config-printer") end },
-- }
-- utilitiesmenu = {
--    { "mail-sync" , function() awful.spawn("alacritty -t floater -e mbsync -a ; mu index") end },
--    { "mail-send" , function() awful.spawn("alacritty -t floater -e msmtp-runqueue.sh") end },
--    { "system-update" , function() awful.spawn("alacritty -t floater -e sudo pacman -Syu") end }
-- }
-- musicmenu = {
--    { "Next" , function() awful.spawn("mpc next") end },
--    { "Prev" , function() awful.spawn("mpc prev") end },
--    { "Toggle" , function() awful.spawn("mpc toggle") end },
--    { "Clear Playlist" , function() awful.spawn("mpc clear") end },
--    { "Update Library" , function() awful.spawn("mpc update") end },
-- }

-- mymainmenu = awful.menu({ items = {
-- 			     { "Terminal", terminal },
-- 			     { "Browser" , browser},
-- 			     { "Awesome", myawesomemenu },
-- 			     { "Apps", appmenu },
-- 			     { "Utilities", utilitiesmenu },
-- 			     { "Configuration" , configurationmenu },
-- 			     { "Music", musicmenu },
-- }})
mymainmenu = freedesktop.menu.build({
      before = {
         { "Awesome", myawesomemenu , beautiful.awesome_icon },
      },
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })


menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a wibox for each screen and add it
-- Create a textclock widget
local clockicon = wibox.widget.imagebox(beautiful.clock_icon)
local mytextclock = wibox.widget.textclock(markup(beautiful.clockwidget_label_color, " %H:%M ") )

local spr   = wibox.widget.textbox(' ')


local batteryicon = wibox.widget.imagebox(beautiful.bat_icon)
local batterywidget = lain.widget.bat({
      battery = "BAT0",
      settings = function()
         local perc = bat_now.perc
         color = beautiful.low_color
         if tonumber(perc) < 50
         then
            color = beautiful.medium_color
         end
         if (tonumber(perc) < 30)
         then
            color = beautiful.high_color
         end
         if bat_now.ac_status == 1
         then
            perc = perc .. "(Powered)"
         end
         widget:set_markup(markup.font(beautiful.widget_font,markup(beautiful.batwidget_label_color, " BAT: ") .. markup(color , perc .. "% " ) ))
      end
})

batterywidget.widget:buttons (
   awful.util.table.join(
      awful.button( {} , 1 , function ()
            awful.spawn.easy_async("acpi",
                                   function(stdout , _ , _ , _)
                                      notification = naughty.notify{
                                         text = stdout,
                                         title = "Battery",
                                         timeout = 30,
                                         hover_timeout = 30,
                                         width = 500,
                                      }
            end)
      end)
   )
)
local memoryicon = wibox.widget.imagebox(beautiful.mem_icon)
local memorywidget = lain.widget.mem({
      settings = function()
         local perc = mem_now.perc
         color = beautiful.low_color
         if tonumber(perc) > 20
         then
            color = beautiful.medium_color
         end
         if (tonumber(perc) > 50)
         then
            color = beautiful.high_color
         end
         widget:set_markup(markup.font(beautiful.widget_font, markup(beautiful.memwidget_label_color, " MEM: ") .. markup(color , mem_now.used .. " MB ")))
      end
})
local cpuicon = wibox.widget.imagebox(beautiful.cpu_icon)
local cpuwidget = lain.widget.cpu({
      settings = function()
         local perc = cpu_now.usage
         color = beautiful.low_color
         if tonumber(perc) > 10
         then
            color = beautiful.medium_color
         end
         if (tonumber(perc) > 50)
         then
            color = beautiful.high_color
         end
         widget:set_markup(markup.font(beautiful.widget_font , markup(beautiful.cpuwidget_label_color, " CPU: ") .. markup(color , cpu_now.usage .. "% ")))
      end
})

local musicicon = wibox.widget.imagebox(beautiful.mpd_icon)
-- local wifiicon = wibox.widget.imagebox(beautiful.wifi_icon)
local mpdwidget = lain.widget.mpd({
      settings = function()
         artist = mpd_now.artist .. " "
         title  = mpd_now.title  .. " "
         color = beautiful.high_color

         if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
            color = beautiful.high_color
         elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
            color = beautiful.high_color
         end

         widget:set_markup(markup.font(beautiful.widget_font, markup(beautiful.mpdwidget_label_color, "MPD: ") .. markup(color, title)))
      end
})
mpdwidget.widget:buttons (
   awful.util.table.join(
      awful.button({} , 1 , function()
            awful.spawn("mpc toggle")
      end),
      awful.button( {} , 3 , function ()
            awful.spawn.easy_async("mpc status",
                                   function(stdout , _ , _ , _)
                                      notification = naughty.notify{
                                         text = stdout,
                                         title = "MPD",
                                         timeout = 30,
                                         hover_timeout = 30,
                                         width = 600,
                                      }
            end)
      end)
   )
)
local pulsewidget = lain.widget.pulse()

local tasklist_buttons = gears.table.join(
   awful.button({ }, 1, function (c)
         if c == client.focus then
            c.minimized = true
         else
            c:emit_signal(
               "request::activate",
               "tasklist",
               {raise = true}
            )
         end
   end),
   awful.button({ }, 3, function()
         awful.menu.client_list({ theme = { width = 250 } })
   end),
   awful.button({ }, 4, function ()
         awful.client.focus.byidx(1)
   end),
   awful.button({ }, 5, function ()
         awful.client.focus.byidx(-1)
end))

local taglist_buttons = gears.table.join(
   awful.button({ }, 1, function(t) t:view_only() end),
   awful.button({ modkey }, 1, function(t)
         if client.focus then
            client.focus:move_to_tag(t)
         end
   end),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, function(t)
         if client.focus then
            client.focus:toggle_tag(t)
         end
   end),
   awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)
local function set_wallpaper(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      set_wallpaper(s)

      -- Each screen has its own tag table.
      awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

      -- Create a promptbox for each screen
      s.mypromptbox = awful.widget.prompt{
         prompt = " Run: "
      }
      -- Create an imagebox widget which will contain an icon indicating which layout we're using.
      -- We need one layoutbox per screen.
      s.mylayoutbox = wibox.container.margin(awful.widget.layoutbox(s) , dpi(1) , dpi(10) , dpi(0) , dpi(0))
      s.mylayoutbox:buttons(gears.table.join(
                               awful.button({ }, 1, function () awful.layout.inc( 1) end),
                               awful.button({ }, 3, function () awful.layout.inc(-1) end),
                               awful.button({ }, 4, function () awful.layout.inc( 1) end),
                               awful.button({ }, 5, function () awful.layout.inc(-1) end)))
      -- Create a taglist widget
      s.mytaglist = awful.widget.taglist {
         screen  = s,
         filter  = awful.widget.taglist.filter.all,
         buttons = taglist_buttons,
      }

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist {
         screen  = s,
         filter  = awful.widget.tasklist.filter.focused,
         buttons = tasklist_buttons
      }

      -- Create the wibox
      s.leftwibox = awful.wibar({ position = "top", screen = s  , shape = gears.shape.rounded_bar  })

      -- Add widgets to the wibox
      s.leftwibox:setup {
         layout = wibox.layout.align.horizontal,
         { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spr,
            -- mylauncher,
            spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
         },
         s.mytasklist, -- Middle widget
         { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            musicicon,
            mpdwidget,
            -- wifiicon,
            -- wifiwidget,
            batteryicon,
            batterywidget.widget,
            memoryicon,
            memorywidget.widget,
            cpuicon,
            cpuwidget.widget,
            pulsewidget.widget,
            clockicon,
            mytextclock,
            spr,
            s.mylayoutbox,
            spr,
         },
      }
end)


-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
                awful.button({ }, 3, function () mymainmenu:toggle() end),
                awful.button({ }, 4, awful.tag.viewnext),
                awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
   awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
      {description="show help", group="awesome"}),
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
      {description = "view previous", group = "tag"}),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
      {description = "view next", group = "tag"}),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
      {description = "go back", group = "tag"}),

   awful.key({ modkey,           }, "j",
      function ()
         awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),
   awful.key({ modkey,           }, "k",
      function ()
         awful.client.focus.byidx(-1)
      end,
      {description = "focus previous by index", group = "client"}
   ),
   awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
      {description = "show main menu", group = "awesome"}),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.global_bydirection("down")    end,
      {description = "swap with window below", group = "client"}),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.global_bydirection("up")    end,
      {description = "swap with window above", group = "client"}),
   awful.key({ modkey, "Shift"   }, "h", function () awful.client.swap.global_bydirection("left")    end,
      {description = "swap with window to the left", group = "client"}),
   awful.key({ modkey, "Shift"   }, "l", function () awful.client.swap.global_bydirection("right")    end,
      {description = "swap with window to the right", group = "client"}),


   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
      {description = "jump to urgent client", group = "client"}),
   -- awful.key({ modkey,           }, "Tab",
   --     function ()
   --         awful.client.focus.history.previous()
   --         if client.focus then
   --             client.focus:raise()
   --         end
   --     end,
   --     {description = "go back", group = "client"}),

   -- Standard program
   -- awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
   --    {description = "open a terminal", group = "launcher"}),
   awful.key({ modkey, "Control" }, "r", awesome.restart,
      {description = "reload awesome", group = "awesome"}),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit,
      {description = "quit awesome", group = "awesome"}),

   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
      {description = "increase master width factor", group = "layout"}),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
      {description = "decrease master width factor", group = "layout"}),
   -- User Programs

   -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
   --           {description = "increase the number of master clients", group = "layout"}),
   -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
   --           {description = "decrease the number of master clients", group = "layout"}),
   -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
   --           {description = "increase the number of columns", group = "layout"}),
   -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
   --           {description = "decrease the number of columns", group = "layout"}),
   awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
      {description = "select next", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
      {description = "select previous", group = "layout"}),
   -- awful.key({ modkey, }, "Tab", revelation ,
   --           {description = "select previous", group = "layout"}),
   -- Quake Type Application
   -- awful.key({ modkey  }, "g", function () scratch.toggle("alacritty  -t scratchpad" , { name = "scratchpad" }) end,
   --           {description = "open a scratchpad", group = "launcher"}),
   -- awful.key({ modkey,           }, "space", function ()
   -- 	  layoutwidget.visible = true
   -- end,
   --           {description = "select next", group = "layout"}),
   -- awful.key({ modkey  }, "z", function() mpc_prompt.launch() end,
   --           {description = "open a scratchpad", group = "launcher"}),

   awful.key({ modkey, "Control" }, "n",
      function ()
         local c = awful.client.restore()
         -- Focus restored client
         if c then
            c:emit_signal(
               "request::activate", "key.unminimize", {raise = true}
            )
         end
      end,
      {description = "restore minimized", group = "client"}),

   -- Prompt
   -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
   --           {description = "run prompt", group = "launcher"}),
   awful.key({ modkey },            "r",     function () command_prompt.launch() end,
      {description = "run prompt", group = "launcher"}),
   awful.key({ modkey },            "m",     function () mpc_prompt.launch() end,
      {description = "mpc prompt", group = "launcher"}),

   awful.key({ modkey }, "x",
      function ()
         awful.prompt.run {
            prompt       = " Run Lua code: ",
            textbox      = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
         }
      end,
      {description = "lua execute prompt", group = "awesome"})
   -- Menubar
   -- awful.key({ modkey }, "p", function() menubar.show() end,
   --           {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
   awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
      {description = "move to screen", group = "client"}),
   awful.key({ modkey, "Shift" }, "t",
      function (c)
         c.fullscreen = not c.fullscreen
         c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
   awful.key({ modkey } , "b" ,
      function(c)
         if( c.border_width == 0)
         then
            c.border_width = beautiful.border_width
         else
            c.border_width = 0
         end
      end,
      {description = "toggle border "}),
   -- awful.key({ modkey , "Shift" } , "b",
   --    function(c)
   --       for _ , c in ipairs(awful.client.get()) do
   --          if (c.border_width == 0)
   --          then
   --             c.border_width = beautiful.border_width
   --          else
   --             c.border_width = 0
   --          end
   --       end
   
   --    end,
   --    {description = "Toggle all borders "}),
   
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
      {description = "close", group = "client"}),
   awful.key({ modkey,  }, "t",  awful.client.floating.toggle                     ,
      {description = "toggle floating", group = "client"}),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
   awful.key({ modkey, "Control" }, "n",      function (c) lain.util.add_tag()               end,
      {description = "add new tag", group = "tag"}),
   awful.key({ modkey, "Control" }, "d",      function (c) lain.util.delete_tag()               end,
      {description = "remove a tag", group = "tag"}),
   awful.key({ modkey, "Control" }, "Right",      function (c) lain.util.move_tag(1)               end,
      {description = "move tag to right", group = "tag"}),
   awful.key({ modkey, "Control" }, "Left",      function (c) lain.util.move_tag(-1)               end,
      {description = "move tag to left", group = "tag"}),
   -- Gaps Bindings
   awful.key({ modkey, "Control" }, "=",      function (c) lain.util.useless_gaps_resize(1)               end,
      {description = "add useless gaps", group = "layout"}),
   awful.key({ modkey, "Control" }, "-",      function (c) lain.util.useless_gaps_resize(-1)               end,
      {description = "remove useless gaps", group = "layout"}),
   -- Toggle Wibox
   awful.key({ modkey , "Control"}, "b", function ()
         for s in screen do
            s.leftwibox.visible = not s.leftwibox.visible
            if s.mybottomwibox then
               s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
         end
   end,
      {description = "toggle wibox", group = "awesome"}),
   -- Notification Keybindings
   awful.key({ modkey,  "Control"  }, "space", function() naughty.destroy_all_notifications() end,
      {description = "destroy all notifications", group = "notification"})
   -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
   --           {description = "toggle keep on top", group = "client"}),
   -- awful.key({ modkey,           }, "n",
   --     function (c)
   --         -- The client currently has the input focus, so it cannot be
   --         -- minimized, since minimized clients can't have the focus.
   --         c.minimized = true
   --     end ,
   --     {description = "minimize", group = "client"}),
   -- awful.key({ modkey,           }, "m",
   --     function (c)
   --         c.maximized = not c.maximized
   --         c:raise()
   --     end ,
   --     {description = "(un)maximize", group = "client"}),
   -- awful.key({ modkey, "Control" }, "m",
   --     function (c)
   --         c.maximized_vertical = not c.maximized_vertical
   --         c:raise()
   --     end ,
   --     {description = "(un)maximize vertically", group = "client"}),
   -- awful.key({ modkey, "Shift"   }, "m",
   --     function (c)
   --         c.maximized_horizontal = not c.maximized_horizontal
   --         c:raise()
   --     end ,
   --     {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   globalkeys = gears.table.join(globalkeys,
                                 -- View tag only.
                                 awful.key({ modkey }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          tag:view_only()
                                       end
                                    end,
                                    {description = "view tag #"..i, group = "tag"}),
                                 -- Toggle tag display.
                                 -- awful.key({ modkey, "Control" }, "#" .. i + 9,
                                 --           function ()
                                 --               local screen = awful.screen.focused()
                                 --               local tag = screen.tags[i]
                                 --               if tag then
                                 --                  awful.tag.viewtoggle(tag)
                                 --               end
                                 --           end,
                                 --           {description = "toggle tag #" .. i, group = "tag"}),
                                 -- Move client to tag.
                                 awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          if tag then
                                             client.focus:move_to_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "move focused client to tag #"..i, group = "tag"})
                                 -- Toggle tag on focused client.
                                 -- awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                 --           function ()
                                 --               if client.focus then
                                 --                   local tag = client.focus.screen.tags[i]
                                 --                   if tag then
                                 --                       client.focus:toggle_tag(tag)
                                 --                   end
                                 --               end
                                 --           end,
                                 --           {description = "toggle focused client on tag #" .. i, group = "tag"})
   )
end

clientbuttons = gears.table.join(
   awful.button({ }, 1, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
   end),
   awful.button({ modkey }, 1, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
         awful.mouse.client.move(c)
   end),
   awful.button({ modkey }, 3, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
         awful.mouse.client.resize(c)
   end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    keys = clientkeys,
                    buttons = clientbuttons,
                    screen = awful.screen.preferred,
                    placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
   },

   -- Floating clients.
   { rule_any = {
        instance = {
           "DTA",  -- Firefox addon DownThemAll.
           "copyq",  -- Includes session name in class.
           "pinentry",
        },
        class = {
           "Arandr",
           "Blueman-manager",
           "Gpick",
           "VirtualBox Machine",
           "feh",
           "lxappearance",
           "system-config-printer",
           "scrcpy",
           "pinentry-qt",
           "Kruler",
           "Emacs",
           "Lxappearance",
           "MessageWin",  -- kalarm.
           "Sxiv",
           "Pcmanfm",
           "MATLAB R2022a - academic use",
           "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
           "Wpa_gui",
           "veromix",
           "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
           "Event Tester",  -- xev.
           "floater",  -- xev.
           "QEMU",  -- xev.
           "scratchpad",  -- xev.
        },
        role = {
           "AlarmWindow",  -- Thunderbird's calendar.
           "ConfigManager",  -- Thunderbird's about:config.
           "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
   }, properties = { floating = true }},

   -- Add titlebars to normal clients and dialogs
   { rule_any = {type = { "normal", "dialog" }
                }, properties = { titlebars_enabled = false }
   },

   -- Set Firefox to always map on the tag named "2" on screen 1.
   { rule = { class = "firefox" },
     properties = { screen = 1, tag = "2"  , floating = true } },

   { rule = { class = "Google-chrome" },
     properties = { screen = 1, tag = "2"  , floating = true } },

   { rule = { class = "discord" },
     properties = { screen = 1 , tag = "2" , floating = true } },

   { rule = { class = "dolphin" },
     properties = { screen = 1 , floating = true } },

   { rule = { class = "jetbrains-studio" },
     properties = { screen = 1 , tag = "2" , floating = true } },

   { rule = { class = "qutebrowser" },
     properties = { screen = 1, tag = "3" } },

   { rule = { class = "mpv" },
     properties = { screen = 1, tag = "4"  , floating = true} },

   { rule = { class = "Steam" },
     properties = { screen = 1, tag = "4"  , floating = true} },

   { rule = { class = "heroic" },
     properties = { screen = 1, tag = "4"  , floating = true} },

   { rule = { class = "Lutris" },
     properties = { screen = 1, tag = "4"  , floating = true} },

   { rule = { class = "Warpinator" },
     properties = { screen = 1, tag = "4"  , floating = true} },

   { rule = { class = "MATLAB R2022a - academic use" },
     properties = { screen = 1, tag = "4"  , floating = true} },

   { rule = { class = "org.remmina.Remmina" },
     properties = { screen = 1, tag = "2"  , floating = true} },

   { rule = { class = "Microsoft Teams - Preview" },
     properties = { screen = 1, tag = "5" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
                         -- Set the windows at the slave,
                         -- i.e. put it at the end of others instead of setting it master.
                         -- if not awesome.startup then awful.client.setslave(c) end

                         if awesome.startup
                            and not c.size_hints.user_position
                            and not c.size_hints.program_position then
                            -- Prevent clients from being unreachable after screen count changes.
                            awful.placement.no_offscreen(c)
                         end
end)
-- client.connect_signal("manage" , function (c)
--     c.shape = gears.shape.rectangle
-- end)


-- -- Add a titlebar if titlebars_enabled is set to true in the rules.
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
                               -- awful.titlebar.widget.minimizebutton(c),
                               awful.titlebar.widget.ontopbutton(c),
                               spacing = -8,
                               layout = wibox.layout.fixed.horizontal
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

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
                         c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
--- Toggle titlebar on or off depending on s. Creates titlebar if it doesn't exist
-- @tparam client c Client to update titlebar state
function manage_titlebar(c)
   -- Fullscreen clients are considered floating. Return to prevent clients from shifting down in fullscreen mode

   if c.fullscreen then
      return
   end
   local show = c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating
   if show then
      if c.titlebar == nil then
         c:emit_signal("request::titlebars", "rules", {})
      end
      awful.titlebar.show(c)
      c.shape = gears.shape.rounded_rect
      c.border_width = false
   else
      awful.titlebar.hide(c)
      c.shape = gears.shape.rectangle
      c.border_width = beautiful.border_width
   end
   -- Prevents titlebar appearing off the screen
   awful.placement.no_offscreen(c)
end

client.connect_signal("property::floating", function(c)
                         manage_titlebar(c)
end)

client.connect_signal("manage" , function(c)
                         manage_titlebar(c)
end)
tag.connect_signal("property::layout", function(t)
                      for _, c in pairs(t:clients()) do
                         manage_titlebar(c)
                      end
end)


local function run_once(cmd_arr)
   for _, cmd in ipairs(cmd_arr) do
      awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
   end
end

-- run_once({ "autostart" }) -- comma-separated entries
run_once({ "sxhkd" }) -- comma-separated entries
-- run_once({ "xrdb -merge ~/.Xresources" }) -- comma-separated entries
-- run_once({ "picom -b " }) -- comma-separated entries

-- bling.module.window_swallowing.start()
-- bling.widget.tag_preview.enable  {
--     show_client_content = false,  -- Whether or not to show the client content
--     x = 10,                       -- The x-coord of the popup
--     y = 10,                       -- The y-coord of the popup
--     scale = 0.25,                 -- The scale of the previews compared to the screen
--     honor_padding = false,        -- Honor padding when creating widget size
--     honor_workarea = false,       -- Honor work area when creating widget size
--     placement_fn = function(c)    -- Place the widget using awful.placement (this overrides x & y)
--         awful.placement.top_left(c, {
--             margins = {
--                 top = 30,
--                 left = 30
--             }
--         })
--     end,
--     background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget 
--         image = beautiful.wallpaper,
--         horizontal_fit_policy = "fit",
--         vertical_fit_policy   = "fit",
--         widget = wibox.widget.imagebox
--     }
-- }
