from libqtile.manager import Key, Screen, Group, Drag
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

fontName = "Terminus"
fontSize = 14

alt = "mod1"
sup = "mod4"

keys = [
    Key(
        [sup], "k",
        lazy.layout.down()
    ),
    Key(
        [sup], "j",
        lazy.layout.up()
    ),
    Key(
        [sup, "control"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [sup, "control"], "j",
        lazy.layout.shuffle_up()
    ),
    Key(
        [sup], "space",
        lazy.layout.next()
    ),
    Key(
        [sup, "shift"], "space",
        lazy.layout.rotate()
    ),
    Key(
        [sup, "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key([sup, "control"], "r", lazy.restart()),

	# My shortcuts
	Key([alt], "Tab", lazy.group.next_window()),
    Key([alt], "F4",  lazy.window.kill()),
	Key([alt], "F11", lazy.window.toggle_fullscreen()),
    Key([alt], "m", lazy.window.toggle_maximize()),

	# Functional keys
	Key([], "XF86Sleep", lazy.spawn("sudo pm-suspend")),
	Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 1+ -q")),
	Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 1- -q")),
	Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle -q")),

	Key([], "XF86AudioPlay", lazy.spawn("mpc toggle -q")),
	Key([], "XF86AudioStop", lazy.spawn("mpc stop -q")),
	Key([], "XF86AudioNext", lazy.spawn("mpc next -q")),
	Key([], "XF86AudioPrev", lazy.spawn("mpc prev -q")),

	# Application shortcuts
	Key([alt], "F2", lazy.spawn("dmenu_run -fn 'Terminus:size=10' -nb '#000000' -nf '#ffffff'")),
	Key([sup], "t", lazy.spawn("urxvt")),
	Key([sup], "w", lazy.spawn("chromium"))
]

mouse = [
    Drag([alt], "Button1", lazy.window.set_position_floating(), start = lazy.window.get_position()),
    Drag([alt], "Button3", lazy.window.set_size_floating(), start = lazy.window.get_size())
]

groups = [
    Group("term", "max"),
    Group("www", "max"),
    Group("dev", "tile"),
    Group("im", "floating"),
    Group("music", "max"),
    Group("etc", "floating")
]

for i in range(1, len(groups) + 1):
	keys.append(
			Key([sup], "F" + str(i), lazy.group[groups[i - 1].name].toscreen())
			)

layouts = [
    layout.Tile(),
    layout.Max(),
	layout.Floating()
]

screens = [
    Screen(
        bottom = bar.Bar(
                    [
                        widget.GroupBox(font = fontName, fontsize = fontSize, padding = 4),
                        widget.WindowName(font = fontName, fontsize = fontSize, padding = 4),
                        widget.CurrentLayout(font = fontName, fontsize = fontSize, padding = 4),
						widget.Volume(channel = "Master", font = fontName, fontsize = fontSize),
                        widget.Systray(),
                        widget.Clock("%H:%M", font = fontName, fontsize = fontSize),
                    ],
                    30,
                ),
    ),
]

@hook.subscribe.client_new
def dialogs(window):
    if (window.window.get_wm_type() == 'dialog' or window.window.get_wm_transient_for()):
        window.floating = True

@hook.subscribe.client_new
def grouping(window):
    if window.match(wmclass = "chromium"):
        window.togroup("www")

main = None
follow_mouse_focus = True
cursor_warp = True
floating_layout = layout.Floating()

