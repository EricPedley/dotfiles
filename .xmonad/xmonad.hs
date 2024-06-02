import XMonad
import XMonad.Layout (Tall, Full)
import XMonad.Layout.Grid (Grid(..))
import qualified XMonad.StackSet as W
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.ManageHelpers -- has doFloat, but the qualified import doesn't work
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.UrgencyHook
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders (smartBorders)

myLayouts = layoutTall ||| layoutFull ||| layoutGrid
    where
      layoutTall = smartBorders $ Tall 1 (3/100) (1/2)
      layoutFull = smartBorders $ Full
      layoutGrid = smartBorders $ Grid
 
-- use xev to get the key names
myKeys conf@(XConfig {modMask = modKey}) = 
 [ 
  ((modKey .|. shiftMask, xK_s), spawn "flameshot gui"),
  ((modKey .|. shiftMask, xK_l), spawn "slock"),
  ((modKey, xK_b), spawn "/home/eric/scripts/display-battery"),
  ((modKey, xK_BackSpace), spawn "firefox"),
  ((modKey .|. shiftMask, xK_BackSpace), spawn "school"),
  ((modKey, xK_v), spawn "rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'"),
  ((modKey, xK_o), spawn "rofi -show run"),
  ((modKey, xK_p), spawn "rofi -show window"),
  ((modKey, xK_bracketleft), spawn "rofi -show vscode-recent -modi vscode-recent"),
  ((modKey, xK_period), spawn "rofimoji --skin-tone neutral --action clipboard"),
  ((modKey, xK_Return), spawn "xterm"),
  ((modKey, xK_Left), prevWS),
  ((modKey, xK_Right), nextWS),
  ((modKey, xK_a), windows $ W.greedyView "1"),
  ((modKey .|. shiftMask, xK_a), windows $ W.shift "1"),
  ((modKey, xK_s), windows $ W.greedyView "2"),
  ((modKey .|. shiftMask, xK_s), windows $ W.shift "2"),
  ((modKey, xK_d), windows $ W.greedyView "3"),
  ((modKey .|. shiftMask, xK_d), windows $ W.shift "3"),
  ((modKey, xK_f), windows $ W.greedyView "4"),
  ((modKey .|. shiftMask, xK_f), windows $ W.shift "4"),
  ((modKey, xK_z), windows $ W.greedyView "5"),
  ((modKey .|. shiftMask, xK_z), windows $ W.shift "5"),
  ((modKey, xK_x), windows $ W.greedyView "6"),
  ((modKey .|. shiftMask, xK_x), windows $ W.shift "6"),
  ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 5%-"),
  ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%"),
  ((0, xF86XK_AudioPlay), spawn "playerctl play-pause"),
  ((0, xF86XK_AudioPrev), spawn "playerctl previous"),
  ((0, xF86XK_AudioNext), spawn "playerctl next"),
  ((0, xF86XK_AudioLowerVolume), spawn "playerctl volume 0.1-"),
  ((0, xF86XK_AudioRaiseVolume), spawn "playerctl volume 0.05+"),
  ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
 ]

myManageHook = composeAll
    [ isDialog --> doFloat
    ]

myConfig = def 
        { modMask = mod4Mask, -- Use Super instead of Alt
          focusedBorderColor = "#888888",
          focusFollowsMouse = True,
          normalBorderColor = "#000000",
          layoutHook = myLayouts,
          manageHook = myManageHook
          -- more changes
        }   

main = xmonad $ setEwmhActivateHook doAskUrgent . ewmh $ myConfig `additionalKeys` (myKeys myConfig) 
