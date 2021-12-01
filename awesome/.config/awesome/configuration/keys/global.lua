local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local beautiful = require("beautiful")

require("awful.autofocus")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local modkey = require("configuration.keys.mod").modKey
local apps = require("configuration.apps")

-- Keybindings starts from here
globalKeys = gears.table.join(

	-- Terminal the GOD
	awful.key({ modkey }, "Return", function()
		awful.spawn(apps.terminal)
	end, {
		description = "open a terminal",
		group = "launcher",
	}),

	-- Web Browser
	awful.key({ modkey }, "w", function()
		awful.spawn(apps.browser)
	end, {
		description = "open a browser",
		group = "launcher",
	}),

	-- File Explorer
	awful.key({ modkey }, "n", function()
		awful.spawn(apps.explorer)
	end, {
		description = "open a file explorer",
		group = "launcher",
	}),

	-- Emacsclient editor
	awful.key({ modkey }, "e", function()
		awful.spawn(apps.editor)
	end, {
		description = "open a editor",
		group = "launcher",
	}),

	-- Menubar
	awful.key({ modkey }, "d", function()
		menubar.show()
	end, {
		description = "show the menubar",
		group = "launcher",
	}),

	awful.key({ modkey }, "x", function()
		awful.util.spawn(".local/bin/dm-logout")
	end, {
		description = "logout menu",
		group = "script keys",
	}),

	awful.key({ modkey }, "r", function()
		awful.util.spawn(".local/bin/dm-record")
	end, {
		description = "record menu",
		group = "script keys",
	}),

	awful.key({ modkey }, "p", function()
		awful.util.spawn(".local/bin/dm-kill")
	end, {
		description = "program kill menu",
		group = "script keys",
	}),

	awful.key({ modkey, "Shift" }, "w", function()
		awful.util.spawn(".local/bin/dm-wifi")
	end, {
		description = "dm wifi menu",
		group = "script keys",
	}),

	awful.key({ modkey }, "m", function()
		awful.util.spawn(".local/bin/dm-sounds")
	end, {
		description = "dm music menu",
		group = "script keys",
	}),

	awful.key({}, "Print", function()
		awful.util.spawn("scrot")
	end, {
		description = "Scrot",
		group = "screenshots",
	}),

	awful.key({}, "XF86AudioRaiseVolume", function()
		os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
		beautiful.volume.update()
	end),

	awful.key({}, "XF86AudioLowerVolume", function()
		os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
		beautiful.volume.update()
	end),

	awful.key({}, "XF86AudioMute", function()
		os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
		beautiful.volume.update()
	end),

	-- {{{ Key bindings
	awful.key({ modkey }, "?", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- Applications

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, {
		description = "focus next by index",
		group = "client",
	}),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, {
		description = "focus previous by index",
		group = "client",
	}),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, {
		description = "swap with next client by index",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, {
		description = "swap with previous client by index",
		group = "client",
	}),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, {
		description = "focus the next screen",
		group = "screen",
	}),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, {
		description = "focus the previous screen",
		group = "screen",
	}),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, {
		description = "go back",
		group = "client",
	}),

	-- Standard program
	awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "e", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, {
		description = "increase master width factor",
		group = "layout",
	}),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, {
		description = "decrease master width factor",
		group = "layout",
	}),

	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, {
		description = "select next",
		group = "layout",
	})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = { description = "view tag #", group = "tag" }
		descr_toggle = { description = "toggle tag #", group = "tag" }
		descr_move = { description = "move focused client to tag #", group = "tag" }
		descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
	end
	globalKeys = awful.util.table.join(
		globalKeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, descr_view),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, descr_toggle),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if _G.client.focus then
				local tag = _G.client.focus.screen.tags[i]
				if tag then
					_G.client.focus:move_to_tag(tag)
				end
			end
		end, descr_move),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if _G.client.focus then
				local tag = _G.client.focus.screen.tags[i]
				if tag then
					_G.client.focus:toggle_tag(tag)
				end
			end
		end, descr_toggle_focus)
	)
end

return globalKeys
-- Keybindings ends here
