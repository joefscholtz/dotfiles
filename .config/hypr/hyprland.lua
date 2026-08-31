---@module 'hl'

-- Resolve directory path relative to hyprland.lua
local current_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"
local env_dir = current_dir .. ".env"
local defaults_file = env_dir .. "/defaults.lua"
local all_file = env_dir .. "/all.lua"

-- Ensure .env/all.lua exists; create it from defaults.lua if missing
local file = io.open(all_file, "r")
if file then
	file:close()
else
	local src_file = io.open(defaults_file, "r")
	if src_file then
		local content = src_file:read("*a")
		src_file:close()

		local dest_file = io.open(all_file, "w")
		if dest_file then
			dest_file:write(content)
			dest_file:close()
		end
	end
end

-- Source the local environment Lua file directly
dofile(all_file)

-- Launch topbar and set wallpaper

-- exec-once = mpvpaper -vs -f -o "no-audio loop --panscan=1" ALL $HOME/.config/assets/wallpapers/forest01.gif
-- exec-once = mpvpaper -vs -f -o "no-audio loop --panscan=1 --cache=no --demuxer-max-bytes=100M --demuxer-max-back-bytes=50M" ALL $HOME/.config/assets/wallpapers/forest01.mp4
-- exec-once = mpvpaper -vs -f $monitor_name ~/.config/assets/wallpapers/void.jpg &
-- exec-once = quickshell
-- exec-once = clipse -listen

-- Clipboard

-- windowrule = float, class:(clipse)
-- windowrule = size 622 652, class:(clipse)
-- windowrule = stayfocused, class:(clipse)
-- bind = SUPER, V, exec, kitty --class clipse -e clipse

-- Set programs that you use

local terminal = "kitty"
local fileManager = "dolphin"
local menu = 'rofi -modes drun,calc,window -show drun -config os.getenv("HOME")/.config/rofi/config.rasi'
local calc = 'rofi -modes calc -show calc -config os.getenv("HOME")/.config/rofi/config.rasi'

-- Some default env vars.

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "kvantum")
hl.env("ICON_THEME", "Bibata-Modern-Classic")

hl.config({
	input = {
		kb_layout = "br",
		kb_options = "caps:none",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = false,
		},
		sensitivity = 0,
		-- -1.0 to 1.0, 0 means no modification.
	},
})

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 5,
		border_size = 3,
		-- dracula
		layout = "scrolling",
		-- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
		allow_tearing = false,
		col = {
			active_border = "rgb(bd93f9)",
			inactive_border = "rgba(44475aaa)",
		},
	},
})

hl.config({
	cursor = {
		inactive_timeout = 0,
	},
})

hl.config({
	decoration = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
		rounding = 15,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},
})

hl.config({
	animations = {
		enabled = true,
		-- Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
	},
})
hl.curve("myBezier", {
	type = "bezier",
	points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

hl.config({
	dwindle = {
		-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		preserve_split = true,
		-- you probably want this
	},
})

hl.config({
	master = {
		-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
		new_status = "master",
	},
})

hl.config({
	misc = {
		force_default_wallpaper = 0,
		-- Set to 0 or 1 to disable the anime mascot wallpapers
	},
})

-- windowrulev2 = suppressevent maximize, class:.*

hl.window_rule({
	name = "tile_on_134",
	match = {
		class = "^(kitty)$",
	},
	tile = true,
})

-- windowrule = plugin:hyprbars:no_bar,class:^(kitty)
-- windowrule = plugin:hyprbars:no_bar,class:^(google-chrome)$
-- windowrule = plugin:hyprbars:no_bar,class:^(firefox)$

hl.window_rule({
	name = "workspace_special_ki_138",
	match = {
		class = "^(kitty)$",
		title = "btop",
	},
	workspace = "special:kittybtop",
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd('[workspace special:kittybtop,title:btop] kitty "btop"'))
hl.bind(mainMod .. " + " .. "Q", hl.dsp.window.close())
hl.bind(mainMod .. " + " .. "X", hl.dsp.window.close())
hl.bind(mainMod .. " + " .. "T", hl.dsp.exec_cmd('kitty --class "kitty"'))
hl.bind(mainMod .. " + " .. "Y", hl.dsp.exec_cmd("restart_waybar.sh"))
hl.bind(mainMod .. " + " .. "M", hl.dsp.exit())
hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + " .. "F", hl.dsp.window.float())

hl.bind(
	mainMod .. " + " .. "R",
	hl.dsp.exec_cmd(
		"rofi -modes drun,calc,window -show drun -config " .. os.getenv("HOME") .. "/.config/rofi/config.rasi"
	)
)

hl.bind(
	mainMod .. " + " .. "C",
	hl.dsp.exec_cmd("rofi -modes calc -show calc -config " .. os.getenv("HOME") .. "/.config/rofi/config.rasi")
)

hl.bind(mainMod .. " + " .. "P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + " .. "S", hl.dsp.window.move({ workspace = "special" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + " .. "H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "J", hl.dsp.focus({ direction = "down" }))

-- Move windows

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "J", hl.dsp.window.move({ direction = "down" }))

-- bind = $mainMod SHIFT, H, layoutmsg, movewindowto l
-- bind = $mainMod SHIFT, L, layoutmsg, movewindowto r
-- bind = $mainMod SHIFT, K, layoutmsg, movewindowto u
-- bind = $mainMod SHIFT, J, layoutmsg, movewindowto d
-- Switch workspaces with mainMod + [0-9]

hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + " .. 8, hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + " .. 9, hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)

--bind = $mainMod, S, togglespecialworkspace, magic
--bind = $mainMod SHIFT, S, movetoworkspace, special:magic
-- Scroll through existing workspaces with mainMod + scroll

hl.bind(mainMod .. " + " .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + " .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging

hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

--Screenshot
-- Screenshot a window
hl.bind(mainMod .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- Screenshot a monitor
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output --freeze"))
-- Screenshot a region
-- hl.bind(local_var_shiftMod .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -m region --freeze"))

-- Screenshot another monitor
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "PRINT",
	hl.dsp.exec_cmd(os.getenv("HOME") .. "/bin/select_monitor_screenshot.sh")
)

-- -- TODO: manual review (unknown dispatcher: gloview:toggle)
-- hl.bind("SUPER + TAB", hl.dsp.gloview:toggle())
--
-- -- TODO: manual review (unknown dispatcher: gloview:desktop)
-- hl.bind("SUPER + SHIFT + TAB", hl.dsp.gloview:desktop())
--
-- -- TODO: manual review (unknown dispatcher: gloview:allworkspaces)
-- hl.bind("SUPER + CTRL + TAB", hl.dsp.gloview:allworkspaces())
--
-- -- TODO: manual review (unknown dispatcher: gloview:next)
-- hl.bind("SUPER + bracketright", hl.dsp.gloview:next())
--
-- -- TODO: manual review (unknown dispatcher: gloview:prev)
-- hl.bind("SUPER + bracketleft", hl.dsp.gloview:prev())
--
-- -- TODO: manual review (unknown dispatcher: gloview:setworkspace)
-- hl.bind("SUPER + 2", hl.dsp.gloview:setworkspace(2))
--
-- hl.plugin("hyprbars", function()
--     bar_height = 15,
--     bar_padding = 20,
--     bar_title_enabled = false,
--     bar_color = "rgb(11111B)",
--     hyprbars-button = { "rgb(FF5555)", 12, "", "hyprctl dispatch killactive" },
--     hyprbars-button = { "rgb(50FA7B)", 12, "", "hyprctl dispatch fullscreen 1" },
--     hyprbars-button = { "rgb(F1FA8C)", 12, "", "hyprctl dispatch togglefloating" },
--     on_double_click = "hyprctl dispatch fullscreen 1",
-- end)
-- hl.plugin("hyprscrolling", function()
--     column_width = 0.485,
--     focus_fit_method = 1,
--     fullscreen_on_one_column = true,
-- end)
-- hl.plugin("hyprwinwrap", function()
--     class = "hyprwinwrap-wallpaper",
-- end)
-- hl.plugin("dynamic-cursors", function()
--     -- enables the plugin
--     enabled = true,
--     -- sets the cursor behaviour, supports these values:
--     -- tilt    - tilt the cursor based on x-velocity
--     -- rotate  - rotate the cursor based on movement direction
--     -- stretch - stretch the cursor shape based on direction and velocity
--     -- none    - do not change the cursors behaviour
--     mode = "stretch",
--     -- minimum angle difference in degrees after which the shape is changed
--     -- smaller values are smoother, but more expensive for hw cursors
--     threshold = 2,
--     -- for mode = stretch
--     -- configure shake to find
--     -- magnifies the cursor if its is being shaken
--     -- use hyprcursor to get a higher resolution texture when the cursor is magnified
--     -- see the `hyprcursor` section below
-- end)

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd(
		"hyprland-autoname-workspaces -c "
			.. os.getenv("HOME")
			.. "/.config/hypr/hyprland-autoname-workspaces-config.toml & waybar &"
	)
	hl.exec_cmd(
		'mpvpaper -vs -f -o "no-audio loop --gpu-api=vulkan --hwdec=auto-safe --panscan=1 --cache=no --demuxer-max-bytes=100M --demuxer-max-back-bytes=50M" ALL '
			.. os.getenv("HOME")
			.. "/.config/assets/wallpapers/forest01.mp4"
	)
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24 &")
end)
