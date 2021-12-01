local awful = require("awful")
local beautiful = require("beautiful")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup")

local apps = require("configuration.apps")

local myawesomemenu = {
	{
		"Hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "Manual", string.format("%s -e man awesome", apps.terminal) },
	{ "Edit config", string.format("%s -e %s %s", apps.terminal, apps.editor, awesome.conffile) },
	{ "Restart", awesome.restart },
	{
		"Quit",
		function()
			awesome.quit()
		end,
	},
}

awful.util.mymainmenu = freedesktop.menu.build({
	before = {
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
		-- other triads can be put here
	},
	after = {
		{ "Open terminal", apps.terminal },
		-- other triads can be put here
	},
})
