import Control.Arrow(first)
import Data.List
import Data.Tree
import Data.Tuple
import System.IO
import System.Exit
import Data.Maybe
import XMonad
import qualified Data.Map as M
import qualified Data.Map.Strict as Map
import qualified XMonad.StackSet as W

import XMonad.Actions.FloatKeys
import XMonad.Actions.NoBorders
import XMonad.Actions.Search
import XMonad.Actions.Submap
import XMonad.Actions.WithAll
import XMonad.Actions.Minimize

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Minimize

import XMonad.Util.Cursor
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.Replace

myBorderWidth = 1
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:JetBrains Mono:size=14"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#282a36"
    , swn_color             = "#f8f8f2"
    }
altMask :: KeyMask
altMask = mod1Mask
myGapsDiff = 10
myNormalBorderColor  = "#6272a4"
myFocusedBorderColor = "#ffb86c"
myTerminal = "alacritty"

myStartupHook = do
    spawnOnce "feh --no-fehbg --bg-scale ~/.config/wallpaper/wallpaper.png &"
    spawnOnce "setxkbmap -option ctrl:nocaps &"
    spawnOnce "killall unclutter;unclutter &"
    spawnOnce "redshift -PO 3400 &"
    -- spawnOnce "killall transmission-daemon ;transmission-daemon &"
    spawnOnce "emacs --daemon"
    spawnOnce "killall batsignal ; batsignal &"
    spawnOnce "xss-lock betterlockscreenlock &"
    spawnOnce "picom --experimental-backends -b"
    spawnOnce "eww daemon"
    spawnOnce "dunst &"
    setWMName "LG3D"
    setDefaultCursor xC_pirate

myWorkspaces = ["1","2","3","4","5"]
myWorkspaceIndices = Map.fromList $ zipWith (,) myWorkspaces [1..]
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where
            i = fromJust $ Map.lookup ws myWorkspaceIndices


myLayoutHook = spacingRaw False (Border 10 4 4 4) True (Border 10 4 4 4 ) True $ avoidStruts $ minimize ( tiled ) 
    where
            tiled = Tall nmaster delta ratio
            nmaster = 1
            ratio = 1/2
            delta = 1/100

myManageHook = composeAll
        [ className =? "qutebrowser"  --> doShift "3"
        , className =? "Steam"  --> doShift "4"
        , className =? "Microsoft Teams - Preview" --> doShift "5"
        , className =? "VirtualBox Manager" --> doCenterFloat
        , className =? "Steam" --> doCenterFloat
        , className =? "VirtualBox Machine" --> doCenterFloat
        , className =? "discord" --> doShift "3"
        -- , className =? "mpv" --> doCenterFloat 
        , className =? "Yad" --> doCenterFloat
        -- , className =? "Pcmanfm" --> doCenterFloat
        , className =? "feh" --> doCenterFloat
        , className =? "qemu" --> doCenterFloat
        , className =? "Steam" --> doCenterFloat
        , className =? "scrcpy" --> doCenterFloat ]

myKeys conf@(XConfig { XMonad.modMask = modm }) = M.fromList $
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_w, xK_r] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ++ 


    [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

disableBar = do
    sendMessage ToggleStruts

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate'  . W.stack . W.workspace . W.current . windowset


toggleFloat w = windows (\s -> if M.member w (W.floating s)
                then W.sink w s
                else (W.float w (W.RationalRect (1/3) (1/2) (1/2) (4/5)) s))

main = do
    replace
    xmproc <- spawnPipe "xmobar"
    xmonad $  docks $ ewmh defaultConfig {
    -- layoutHook = avoidStruts $ spacing 4 $ layoutHook defaultConfig,
    modMask = mod4Mask,
    logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "#000000,#a3be8c" "" . shorten 100 . wrap " " " "
                , ppCurrent = xmobarColor "#000000,#ebc88b" "" . wrap " " " "
                , ppUrgent = xmobarColor "#000000,#bf616a" ""  . wrap " " " "
                , ppHiddenNoWindows = xmobarColor "#000000,#b48ead" "" . wrap " " " " . clickable
                , ppHidden = xmobarColor "#000000,#81a1c1" "" . wrap " " " " .  clickable
                , ppWsSep = " "
                , ppExtras = [windowCount]
                , ppOrder = \(ws:l:t:ex) -> [ws]++[t]
                , ppSep = " "
                },
    -- terminal = "alacritty",
    terminal = myTerminal,
    startupHook = myStartupHook,
    workspaces = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
    manageHook         = myManageHook,
    layoutHook         = myLayoutHook,
    borderWidth        = myBorderWidth,
    keys               = myKeys,
    -- handleEventHook     = fullscreenEventHook,
    focusFollowsMouse   = False
    } `additionalKeysP`

        [ ("M-<Return>" , spawn "alacritty") -- Spawns Alacritty
        , ("M-;" , spawn "dmenu_run") -- Spawns Djenu
        , ("M-S-;" , spawn "rofi -show drun") -- Spawns Dmenu
        , ("M-S-c" , kill) -- Deletes window
        , ("M-S-a" , killAll) -- Deletes window
        , ("M-<Space>" , sendMessage NextLayout) -- Change Layout
        , ("M-j" , windows W.focusDown) -- Moves focus to next window
        , ("M-S-<Return>" , windows W.swapMaster) -- Swap master and slave window
        , ("M-h" , sendMessage Shrink) -- Shrink size of master window 
        , ("M-l" , sendMessage Expand) -- Expand size of master window 
        , ("M-b", withFocused toggleBorder) -- Toggle Current window border
        , ("M-t", withFocused toggleFloat) -- Toggle Float for Current Window
        , ("M-C-=" , incWindowSpacing 1) --  Increase Gaps
        , ("M-C--" , decWindowSpacing 1) -- Decrease GAps
        , ("M-g" , toggleWindowSpacingEnabled) -- Toggle Gaps
        , ("M-S-b", withAll toggleBorder) -- Toggle All Window border
        , ("M-C-r" , spawn "xmonad --recompile ; xmonad --restart") -- Restart XMonad
        , ("M-S-q" ,io (exitWith ExitSuccess) ) -- Restart XMonad
        , ("<XF86AudioMute>" , spawn "pactl -- set-sink-volume $(pactl get-default-sink) 0% ; volumenotify")  -- Mute Volume
        , ("<XF86AudioNext>" , spawn "playerctl  next") -- Music Next
        , ("<XF86AudioPrev>" , spawn "playerctl  prev") -- Music Prev
        , ("<XF86AudioStop>" , spawn "playerctl -a pause") -- Music Stop
        , ("<XF86AudioPlay>" , spawn "playerctl  play-pause") -- Music Toggle
        , ("<XF86AudioLowerVolume>" , spawn "pactl -- set-sink-volume $(pactl get-default-sink) -5% ; volumenotify") -- Music Toggle
        , ("M-n", withFocused minimizeWindow) -- Minize window
        , ("M-S-n", withLastMinimized maximizeWindowAndFocus) -- Undo the minimize window
        , ("<XF86AudioRaiseVolume>" , spawn "pactl -- set-sink-volume $(pactl get-default-sink) +5% ; volumenotify") -- Music Toggle
        , ("<Print>" , spawn "dm-screenshot") -- Music Toggle
        , ("M-C-k" , spawn "pactl -- set-sink-volume 0 +5%") -- Increase Volume
        , ("M-C-j" , spawn "pactl -- set-sink-volume 0 -5%") -- Decrease Volume
        , ("<XF86MonBrightnessUp>" , spawn "light -A 5 ; brightnessnotify") -- Increases Brightness
        , ("<XF86MonBrightnessDown>" , spawn "light -U 5 ; brightnessnotify") -- Decreases Brightness
        , ("M-C-<Space>" , spawn "dunstctl close") --  Clear Notifications
        , ("M-C-S-<Space>" , spawn "dunstctl history-pop") -- Bring Notification History
        , ("M-f", spawn "emacsclient -c -e '(dired \"~\")'") -- Bring File Manager
        , ("M-C-l" , spawn "betterlockscreen --lock" ) -- Lock the Desktop
        , ("M-C-b", disableBar) -- Toggle Bar
        , ("M-e" , spawn "emacsclient -c") -- Bring the editor
        , ("M-m" , spawn "mpc toggle" )  -- Bring the editor
        , ("M-C-o" , restart "/home/pspiagicw/.config/bin/xmonad-openbox" True)  -- Bring the editor
        ]
