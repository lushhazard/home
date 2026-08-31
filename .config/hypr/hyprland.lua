-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "DP-1",
	mode = "5120x1440@240.49Hz",
	position = "auto",
	scale = "1",
	bitdepth = 10,
	vrr = 0,
	--cm = "wide",
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "foot"
local fileManager = "thunar"
local menu = "fuzzel"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "32")
hl.env("XCURSOR_THEME", "miku-cursor")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_THEME", "miku-cursor")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GOPATH", "/var/go")
--hl.env("MOZC_IBUS_CANDIDATE_WINDOW", "ibus")

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
--
hl.on("hyprland.start", function()
	hl.exec_cmd("otp-daemon")
	hl.exec_cmd("quickshell & hyprpaper & dunst")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("qpwgraph --minimized")
	hl.exec_cmd("wl-paste --type text --watch cliphist store # Stores only text data")
	hl.exec_cmd("wl-paste --type image --watch cliphist store # Stores only image data")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("XDG_MENU_PREFIX=arch- kbuildsycoca6")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("~/scripts/qbit_launch.fish /etc/wireguard/inazuma-NO-42.conf")
	hl.exec_cmd("sudo quadcastrgb solid 110000")
	hl.exec_cmd("hyprctl setcursor miku-cursor 32")
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("easyeffects")
	hl.exec_cmd("obs --startreplaybuffer --minimize-to-tray --disable-shutdown-check")
	hl.exec_cmd("firefox")
end)

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 0,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(FF00FF00)", "rgba(FFFFFF33)" }, angle = 90 },
			inactive_border = "rgba(00000000)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 10,
			passes = 3,
			vibrancy = 0.1696,
		},
		--motion_blur = {
		--	enabled = true,
		--},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 878.5, dampening = 59.29 })

-- do math on the speed value:
-- :'<,'>s:speed = \zs[0-9.]\+:\=str2float(submatch(0))/2.0:
hl.animation({ leaf = "global", enabled = true, speed = 5.0, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 2.695, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 2.395, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.05, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.745, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 0.865, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.73, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 1.515, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 1.905, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2.0, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 0.75, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.895, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 0.695, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 0.97, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 0.605, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 0.97, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 1.0, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		disable_splash_rendering = true,
		font_family = "Cica",
	},
	cursor = {
		inactive_timeout = 2,
	},
	layout = {
		single_window_aspect_ratio = { 18, 9 },
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = -0.8, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
	binds = {
		scroll_event_delay = 0,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
--
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ---- binds keybinds
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
hl.bind(mainMod .. " + N", hl.dsp.layout("togglesplit")) -- dwindle only
--hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. "+ SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+ T", hl.dsp.window.pin({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + F5", hl.dsp.dpms("toggle"))

--hl.bind("SUPER + S", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
hl.bind("SUPER + S", hl.dsp.exec_cmd("obs-cmd replay save"))
hl.bind(
	"SUPER + B",
	hl.dsp.exec_cmd('quickshell ipc call blob toggleVis; hyprctl dispatch focuswindow "title:quickshell_blob"')
)
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + M", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + D", hl.dsp.exec_cmd('hyprctl notify -1 2000 "rgb(ab1eff)" "$(date)"'))
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("discord"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("steam"))
hl.bind(
	"SUPER + V",
	hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu --namespace=clipboard_history -w 128 | cliphist decode | wl-copy")
)
hl.bind("SUPER + SHIFT + Z", hl.dsp.exec_cmd("chromium --app=https://game.mahjongsoul.com/"))
hl.bind("SUPER + SHIFT + G", hl.dsp.exec_cmd("chromium --app=https://192.168.1.137:3000/"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("systemctl reboot --boot-loader-entry=auto-windows"))
hl.bind(
	"ALT + PRINT",
	hl.dsp.exec_cmd(
		'hyprshot -m active -m output --clipboard-only --raw | satty --font-family "Noto Sans CJK JP" --copy-command "wl-copy" --actions-on-enter save-to-clipboard -f -'
	)
)
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -z -o ~/画像/Screenshots/hyprshot -m region"))
hl.bind(
	"SUPER + P",
	hl.dsp.exec_cmd('wl-paste -t image/png | satty --copy-command "wl-copy" --actions-on-enter save-to-clipboard -f -')
)
hl.bind(
	"SUPER + PRINT ",
	hl.dsp.exec_cmd(
		'echo 2 | wf-recorder -a -r 60 -g "0,0 0x0" -f ~/rec/recording_$(date +"%Y-%m-%d_%H:%M:%S.mp4") & hyprctl notify -1 3000 "rgb(ffff22)" "画面の録画を開始しました"'
	)
)
hl.bind(
	"SUPER + CTRL + PRINT",
	hl.dsp.exec_cmd(
		'wf-recorder -a -r 60 -g "$(slurp)" -f ~/rec/recording_$(date +"%Y-%m-%d_%H:%M:%S.mp4") & hyprctl notify -1 3000 "rgb(ffff22)" "画面の一部の録画を開始しました"'
	)
)
hl.bind(
	"SUPER + BACKSPACE",
	hl.dsp.exec_cmd(
		'killall -s SIGINT wf-recorder & hyprctl notify -1 3000 "rgb(33ff77)" "録画を停止しました"'
	)
)
hl.bind("SUPER + W", hl.dsp.exec_cmd('foot --title=ytdrag -e fish -ic "ytdrag (wl-paste)"'))
hl.bind("SUPER + F1", hl.dsp.exec_cmd("~/.config/hypr/gamemode.sh"))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -500, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 500, y = 0, relative = true }))

-- closeWindowBind:set_enabled(false)
hl.bind(
	mainMod .. "+ SHIFT + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local MAX_ZOOM = 10
local MIN_ZOOM = 1
---@param offset number
---@return nil
local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	if offset ~= nil then
		current = current * offset
	elseif current ~= MIN_ZOOM then
		current = MIN_ZOOM
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end
hl.bind("SUPER + mouse_down", function()
	zoom(1.3)
end)
hl.bind("SUPER + mouse_up", function()
	zoom(0.75)
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "windowrule-3",
	float = true,
	match = { title = "ネットワーク接続" },
})
hl.window_rule({
	name = "windowrule-4",
	float = true,
	match = { title = "Pipewire Volume Control" },
})
hl.window_rule({
	name = "windowrule-5",
	float = true,
	size = { "(monitor_w*0.3)", "(monitor_h*0.77)" },
	match = { title = "音量調節" },
})
hl.window_rule({
	name = "windowrule-8",
	float = true,
	size = { "(monitor_w*0.2)", "(monitor_h*0.04)" },
	match = { title = "ytdrag" },
})
hl.window_rule({
	name = "windowrule-9",
	float = true,
	persistent_size = true,
	match = { class = "qimgv" },
})
hl.window_rule({
	name = "windowrule-10",
	float = true,
	pin = true,
	center = true,
	size = { 450, 450 },
	opacity = "1 override 0.5 override",
	--dim_around = true,
	match = { title = "quickshell_blob" },
})
hl.window_rule({
	name = "qbittorrent",
	float = true,
	match = { initial_class = "org.qbittorrent.qBittorrent" },
})
-- hl.window_rule({
-- 	match = { class = "gamescope" },
-- 	immediate = true,
-- })
hl.layer_rule({
	no_screen_share = true,
	match = { namespace = "clipboard_history" },
})

--hl.layer_rule({
--	match = { namespace = "launcher" },
--})
