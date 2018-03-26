local awful = require("awful")
local beautiful = require("beautiful")
beautiful.init( awful.util.getdir("config") .. "/themes/theme.lua" )

icon_button = {}

-- Firefox
icon_button.firefox = awful.widget.button({ image = theme.icon_firefox })
icon_button.firefox:buttons(awful.util.table.join(
  awful.button({}, 1, function () awful.util.spawn("firefox") end)
    ))

-- Chromium
icon_button.chromium = awful.widget.button({ image = theme.icon_chromium })
icon_button.chromium:buttons(awful.util.table.join(
  awful.button({}, 1, function () awful.util.spawn(browser) end)
    ))

-- Calc
icon_button.calc = awful.widget.button({ image = theme.icon_calc })
icon_button.calc:buttons(awful.util.table.join(
  awful.button({}, 1, function () awful.util.spawn("galculator") end)
    ))


-- Terminal
icon_button.terminal = awful.widget.button({ image = theme.icon_terminal })
icon_button.terminal:buttons(awful.util.table.join(
  awful.button({}, 1, function () awful.util.spawn(terminal) end)
    ))

-- Sublime Text
icon_button.subl = awful.widget.button({ image = theme.icon_subl })
icon_button.subl:buttons(awful.util.table.join(
  awful.button({}, 1, function () awful.util.spawn(geditor) end)
    ))

-- File Manager
icon_button.filemgr = awful.widget.button({ image = theme.icon_filemanager })
icon_button.filemgr:buttons(awful.util.table.join(
  awful.button({}, 1, function () awful.util.spawn(file_manager) end)
    ))

-- Keepass
icon_button.keepass = awful.widget.button({ image = theme.icon_keepass })
icon_button.keepass:buttons(awful.util.table.join(
  awful.button({}, 1, function () awful.util.spawn("keepass") end)
    ))

return icon_button