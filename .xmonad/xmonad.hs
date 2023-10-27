import XMonad
import XMonad.Layout (Tall, Full)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.ManageHelpers -- has doFloat, but the qualified import doesn't work
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.UrgencyHook

myLayouts = layoutTall ||| layoutFull
    where
      layoutTall = Tall 1 (3/100) (1/2)
      layoutFull = Full
 
-- use xev to get the key names
myKeys conf@(XConfig {modMask = modKey}) = 
 [ 
  ((modKey .|. shiftMask, xK_s), spawn "flameshot gui"),
  ((modKey .|. shiftMask, xK_l), spawn "slock"),
  ((modKey, xK_BackSpace), spawn "firefox"),
  ((modKey .|. shiftMask, xK_BackSpace), spawn "school"),
  ((modKey, xK_v), spawn "rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'"),
  ((modKey, xK_o), spawn "rofi -show run"),
  ((modKey, xK_p), spawn "rofi -show window"),
  ((modKey, xK_bracketleft), spawn "rofi -show vscode-recent -modi vscode-recent"),
  ((modKey, xK_period), spawn "rofimoji --action clipboard --skin-tone neutral"),
  ((modKey, xK_Return), spawn "xterm"),
  ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 5%-"),
  ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%"),
  ((0, xF86XK_AudioPlay), spawn "playerctl play-pause"),
  ((0, xF86XK_AudioPrev), spawn "playerctl previous"),
  ((0, xF86XK_AudioNext), spawn "playerctl next"),
  ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
 ]

myManageHook = composeAll
    [ isDialog --> doFloat
    ]

myConfig = def 
        { modMask = mod4Mask, -- Use Super instead of Alt
          focusedBorderColor = "#888888",
          normalBorderColor = "#000000",
          layoutHook = myLayouts,
          manageHook = myManageHook
          -- more changes
        }   

main = xmonad $ setEwmhActivateHook doAskUrgent . ewmh $ myConfig `additionalKeys` (myKeys myConfig)
