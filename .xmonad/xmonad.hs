import XMonad
import XMonad.Layout (Tall, Full)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig (additionalKeys)

myLayouts = layoutTall ||| layoutFull
    where
      layoutTall = Tall 1 (3/100) (1/2)
      layoutFull = Full
  
myKeys conf@(XConfig {modMask = modKey}) = 
 [ 
  ((modKey .|. shiftMask, xK_s), spawn "flameshot gui"),
  ((modKey .|. shiftMask, xK_l), spawn "slock"),
  ((modKey, xK_BackSpace), spawn "firefox"),
  ((modKey .|. shiftMask, xK_BackSpace), spawn "school"),
  ((modKey, xK_p), spawn "rofi -show run"),
  ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 5%-"),
  ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%"),
  ((0, xF86XK_AudioPlay), spawn "playerctl play-pause"),
  ((0, xF86XK_AudioPrev), spawn "playerctl previous"),
  ((0, xF86XK_AudioNext), spawn "playerctl next")
 ]

myConfig = def 
        { modMask = mod4Mask, -- Use Super instead of Alt
          focusedBorderColor = "#888888",
          normalBorderColor = "#000000",
          layoutHook = myLayouts

          -- more changes
        }   

main = xmonad $ myConfig `additionalKeys` (myKeys myConfig)
