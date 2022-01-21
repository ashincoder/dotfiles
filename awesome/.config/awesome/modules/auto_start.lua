-- {{{ Autostart windowless processes

local awful = require("awful")

local processes = {
	-- Compositor
	"picom --experimental-backends",
	-- NetworkManager systray applet
	"nm-applet",
	-- Cursor
	"xsetroot -cursor_name left_ptr &",
	-- Emacs daemon
	-- "/usr/bin/emacs --daemon",
}

local function run_once(cmd)
	local running_process = cmd
	local first_space = cmd:find(" ")
	if first_space then
		running_process = cmd:sub(0, first_space - 1)
	end

	awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", running_process, cmd))
end

for _, process in ipairs(processes) do
	run_once(process)
end

-- }}}
