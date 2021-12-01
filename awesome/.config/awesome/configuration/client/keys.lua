local awful = require("awful")
local gears = require("gears")

require("awful.autofocus")
local modkey = require("configuration.keys.mod").modKey
local altkey = require("configuration.keys.mod").altKey

clientKeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, {
		description = "toggle fullscreen",
		group = "client",
	}),
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, {
		description = "move to master",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "m", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, {
		description = "minimize",
		group = "client",
	})
)

return clientKeys
