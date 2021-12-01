local gears = require("gears")
local awful = require("awful")

-- Mousebindings that occur on the desktop
desktopMouse = gears.table.join(awful.button({}, 3, function()
	awful.util.mymainmenu:toggle()
end))

awful.util.taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)

	-- Moves client to clicked tag
	--[[ awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end), --]]
	-- Focuses client to clicked tag
	--[[ awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end), --]]
)

awful.util.tasklist_buttons = gears.table.join(
	-- Minimize the active window when tasklist is clicked
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	-- Menu with current clients when right clicked the tasklist
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end)
)

return desktopMouse
