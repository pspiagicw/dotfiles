local awful = require("awful")
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "setxkbmap -option ctrl:nocaps" }) -- comma-separated entries
run_once({ "batsignal" }) -- comma-separated entries
run_once({ "redshift -PO 3400" }) -- comma-separated entries
run_once({ "xrdb -merge ~/.Xresources" }) -- comma-separated entries
run_once({ "picom -b " }) -- comma-separated entries
