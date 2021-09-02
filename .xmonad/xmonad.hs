import Control.Arrow(first)
import Data.List
import Data.Tree
import Data.Tuple
import System.IO
import System.Exit
import Data.Maybe
import XMonad
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.FloatKeys
import XMonad.Actions.GridSelect
import XMonad.Actions.NoBorders
import XMonad.Actions.Search
import XMonad.Actions.Submap
import XMonad.Actions.WithAll
import XMonad.Actions.WindowBringer
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Accordion
import XMonad.Layout.BoringWindows
import XMonad.Layout.Circle
import XMonad.Layout.DecorationMadness
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.Man
import XMonad.Prompt.Shell
import XMonad.Util.Cursor
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.NamedActions
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import qualified Data.Map as M
import qualified Data.Map.Strict as Map
import qualified XMonad.Actions.Search as S
import qualified XMonad.Actions.TreeSelect as TS
import qualified XMonad.StackSet as W

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
myFocusedBorderColor = "#ff79c6"
myStartupHook = do
    spawnOnce "feh --no-fehbg --bg-scale ~/.config/wallpaper/wallpaper.png &"
    spawnOnce "setxkbmap -option ctrl:nocaps &"
    spawnOnce "killall unclutter;unclutter &"
    spawnOnce "redshift -PO 3400 &"
    spawnOnce "picom -b &"
    spawnOnce "killall transmission-daemon ;transmission-daemon &"
    spawnOnce "emacs --daemon"
    spawnOnce "killall batsignal ; batsignal &"
    spawnOnce "xss-lock betterlockscreenlock &"
    spawnOnce "dunst &"
    spawnOnce "killall mpd; mpd &"
    spawnOnce "mpdnotify"
    setWMName "LG3D"
    setDefaultCursor xC_pirate
myWorkspaces = ["main","sys","browser","media","college"]
myWorkspaceIndices = Map.fromList $ zipWith (,) myWorkspaces [1..]
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ Map.lookup ws myWorkspaceIndices


myLayoutHook = spacingRaw False (Border 4 4 4 4) True (Border 4 4 4 4 ) True $ avoidStruts $ showWName' myShowWNameTheme
    ( tiled ) 
    where
        --ResizeTall Definat
        -- resizeTall = ResizableTall nmaster delta ratio []
        -- default tiling algorithm partition
        tiled = Tall nmaster delta ratio
        -- Default no of window in master area
        nmaster = 1
        -- Default proportion of screen divided between screen
        ratio = 1/2
        -- Precent of screen to increment while resizing
        delta = 1/100
        -- Tabbed layout with custom font
        -- tabbing = tabbed shrinkText myTabLayoutConfig
        -- Custom Tabbed Layout Config
        -- myTabLayoutConfig = def {
                              -- fontName = "xft:JetBrains Mono:size=7",
                              -- activeBorderColor = "#ffb86c",
                              -- inactiveBorderColor = "#50fa7b",
                              -- activeTextColor = "#f8f8f2",
                              -- inactiveTextColor = "#f8f8f2",
                              -- activeColor = "#282a36",
                              -- inactiveColor = "#282a36"
                              --   }

myManageHook = composeAll
                [ className =? "qutebrowser"  --> doShift "browser"
                -- , className =? "st-256color" --> doFloat
                , className =? "Microsoft Teams - Preview" --> doShift "college"
                , className =? "VirtualBox Manager" --> doCenterFloat
                , className =? "discord" --> doShift "browser"
                , className =? "mpv"  --> hasBorder False
                , className =? "mpv" --> doCenterFloat
                , className =? "Pcmanfm" --> doCenterFloat
                -- , className =? "Thunderbird" --> doShift "college"
                , className =? "Zenity" --> doCenterFloat
                , className =? "feh" --> doCenterFloat
                , className =? "qemu" --> doCenterFloat
                , className =? "Steam" --> doCenterFloat
                , className =? "mpv"  --> doShift "media" ]

toggleFloat w = windows (\s -> if M.member w (W.floating s)
                        then W.sink w s
                        else (W.float w (W.RationalRect (1/3) (1/2) (1/2) (4/5)) s))
myKeys conf@(XConfig { XMonad.modMask = modm }) = M.fromList $
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ++ 

  
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate'  . W.stack . W.workspace . W.current . windowset
main = do
        xmproc <- spawnPipe "xmobar"
        xmonad $  docks $ ewmh defaultConfig {
        -- layoutHook = avoidStruts $ spacing 4 $ layoutHook defaultConfig,
        modMask = mod4Mask,
        logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#50fa7b" "" . shorten 50
                        , ppUrgent = xmobarColor "#ff5555" "" .wrap "*" "*" 
                        , ppHiddenNoWindows = xmobarColor "#f8f8f2" "" . clickable
                        , ppHidden = xmobarColor "#8be9fd" "" . wrap "*" "" . clickable
                        , ppWsSep = " "
                        , ppExtras = [windowCount]
                        , ppOrder = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        , ppSep = " | "
                        },
    terminal = "alacritty",
    startupHook = myStartupHook,
    workspaces = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
    manageHook         = myManageHook,
    layoutHook         = myLayoutHook,
    borderWidth        = myBorderWidth,
    keys               = myKeys,
    handleEventHook     = fullscreenEventHook,
    focusFollowsMouse   = False
    } `additionalKeysP`
-- START_KEYS
-- WINDOW MANAGEMENT
            [ ("M-<Return>" , spawn "alacritty") -- Spawns Alacritty
            , ("M-;" , spawn "dmenu_run") -- Spawns Dmenu
            , ("M-S-c" , kill) -- Deletes window
            , ("M-S-a" , killAll) -- Deletes window
            , ("M-<Space>" , sendMessage NextLayout) -- Change Layout
            , ("M-j" , windows W.focusDown) -- Moves focus to next window
            , ("M-k" , windows W.focusUp) -- Moves focus to prev window
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
-- MEDIA KEYS
            , ("<XF86AudioMute>" , spawn "pactl -- set-sink-volume $(pactl get-default-sink) 0%")  -- Mute Volume
            , ("<XF86AudioNext>" , spawn "mpc next") -- Music Next
            , ("<XF86AudioPrev>" , spawn "mpc prev") -- Music Prev
            , ("<XF86AudioStop>" , spawn "mpc stop") -- Music Stop
            , ("<XF86AudioPlay>" , spawn "mpc toggle") -- Music Toggle
            , ("<XF86AudioLowerVolume>" , spawn "pactl -- set-sink-volume $(pactl get-default-sink) -5%") -- Music Toggle
            , ("<XF86AudioRaiseVolume>" , spawn "pactl -- set-sink-volume $(pactl get-default-sink) +5%") -- Music Toggle
            , ("<Print>" , spawn "dm-screenshot") -- Music Toggle
            , ("M-C-k" , spawn "pactl -- set-sink-volume 0 +5%") -- Increase Volume
            , ("M-C-j" , spawn "pactl -- set-sink-volume 0 -5%") -- Decrease Volume
-- BRIGHTNESS CONTROL
            , ("<XF86MonBrightnessUp>" , spawn "light -A 5 &") -- Increases Brightness
            , ("<XF86MonBrightnessDown>" , spawn "light -U 5 &") -- Decreases Brightness
-- APPLICATIONS
            , ("M-C-<Space>" , spawn "dunstctl close") --  Clear Notifications
            , ("M-C-S-<Space>" , spawn "dunstctl history-pop") -- Bring Notification History
            , ("M-f", spawn "emacsclient -c -e '(dired \"~\")'") -- Bring File Manager
            , ("M-C-l" , spawn "betterlockscreen --lock" ) -- Lock the Desktop
            , ("M-C-b", sendMessage ToggleStruts) -- Toggle Bar
            , ("M-e" , spawn "emacsclient -c") -- Bring the editor

-- END_KEYS
            ]

            
