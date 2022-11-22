-------------------------------------------------
-- The Ultimate Volume Widget for Awesome Window Manager
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volume-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")

local function GET_VOLUME_CMD(device) return 'amixer -D ' .. device .. ' sget Master' end
local function TOG_VOLUME_CMD(device) return 'amixer -D ' .. device .. ' sset Master toggle' end

local volume = {}

local function worker(user_args)

    local args = user_args or {}

    local mixer_cmd = args.mixer_cmd or 'pavucontrol'
    local refresh_rate = args.refresh_rate or 1
    local device = args.device or 'pulse'

    volume.widget = require("x.volume-icon-widget").get_widget(args)

    local function update_graphic(widget, stdout)
        local mute = string.match(stdout, "%[(o%D%D?)%]") -- \[(o\D\D?)\] - [on] or [off]
        if mute == 'off' then widget:mute()
        elseif mute == 'on' then widget:unmute()
        end
        local volume_level = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
        volume_level = string.format("% 3d", volume_level)
        widget:set_volume_level(volume_level)
    end
    function volume:toggle()
        spawn.easy_async(TOG_VOLUME_CMD(device), function(stdout) update_graphic(volume.widget, stdout) end)
    end

    function volume:mixer()
        if mixer_cmd then
            spawn.easy_async(mixer_cmd)
        end
    end

    volume.widget:buttons(
        awful.util.table.join(
            awful.button({}, 2, function() volume:mixer() end),
            awful.button({}, 1, function() volume:toggle() end)
        )
    )

    watch(GET_VOLUME_CMD(device), refresh_rate, update_graphic, volume.widget)

    return volume.widget
end

return setmetatable(volume, { __call = function(_, ...) return worker(...) end })
