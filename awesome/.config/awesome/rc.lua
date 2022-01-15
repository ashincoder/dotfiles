-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")

-- Init all modules
require("modules.error_handling")
require("modules.set_wallpaper")
require("modules.auto_start")
require("modules.sloppy_focus")

-- Theme handling library
local beautiful = require("beautiful")
local themes = {
	"rose-pine", -- 1
	"doom-one", -- 2
}

local chosen_theme = themes[1]

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))

-- Setup all configurations
require("configuration.tags")
require("configuration.client")
require("configuration.init")
require("configuration.menu")

_G.root.keys(require("configuration.keys.global"))
_G.root.buttons(require("configuration.mouse"))

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
	beautiful.at_screen_connect(s)
end)

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)
