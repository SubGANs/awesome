local calendar = require('calendar')


widgets = {}

-- Виджет раскладки
--mykeyboardlayout = awful.widget.keyboardlayout()
widgets.keyboardlayout = {
  {
    {
      {
        widget = awful.widget.keyboardlayout()
      },
      left   = 15,
      right  = 15,
      top    = 2,
      bottom = 2,
      widget = wibox.container.margin
    },
    bg = "#002b3611",
    set_shape = function(cr, width, height)
      gears.shape.powerline(cr, width, height, (height / 2) * (-1))
    -- gears.shape.transform(shape.powerline) : translate(0, 25) (cr,width,height, (height / 2 ) * - 1)
    end,
    widget = wibox.container.background
  },
  left   = 0,
  right  = -13,
  top    = 0,
  bottom = 0,
  widget = wibox.container.margin
}

-- {{{ Wibar
-- Виджет часов
textclock = wibox.widget.textclock("%d.%m.%Y %A %H:%M:%S", 1)
widgets.textclock = {
  {
    {
      {
        widget = textclock
      },
      left   = 15,
      right  = 15,
      top    = 2,
      bottom = 2,
      widget = wibox.container.margin
    },
    bg = "#4B696D",
    set_shape = function(cr, width, height)
      gears.shape.powerline(cr, width, height, (height / 2) * (-1))
      --gears.shape.transform(shape.powerline) : translate(0, 25) (cr,width,height, (height / 2 ) * - 1)
    end,
    widget = wibox.container.background
  },
  left   = 0,
  right  = -13,
  top    = 0,
  bottom = 0,
  widget = wibox.container.margin
}
            
-- Всплывающий календарь
calendar({}):attach(textclock)


-- Виджет будильника
budiltext = wibox.widget.textbox()
budiltimer = timer({ timeout = 5 })
budiltimer:connect_signal("timeout", function() awful.spawn.easy_async(os.getenv("HOME")..'/.config/awesome/scripts/snakyalarm_time.sh',
                                                    function(stdout) budiltext:set_text(stdout) end) end)
budiltimer:start()

widgets.alarm = {
  {
    {
      {
        widget = budiltext
      },
      left   = 15,
      right  = 15,
      top    = 2,
      bottom = 2,
      widget = wibox.container.margin
    },
    bg = theme.colors.cyan,
    --bg = "#a01c1c",
    set_shape = function(cr, width, height)
      gears.shape.powerline(cr, width, height, (height / 2) * (-1))
    -- gears.shape.transform(shape.powerline) : translate(0, 25) (cr,width,height, (height / 2 ) * - 1)
    end,
    widget = wibox.container.background
  },
  left   = 0,
  right  = -13,
  top    = 0,
  bottom = 0,
  widget = wibox.container.margin
}

-- Виджет трея
widgets.systray = {
  {
    {
      {
        widget = wibox.widget.systray()
      },
      left   = 15,
      right  = 15,
      top    = 2,
      bottom = 2,
      widget = wibox.container.margin
    },
    bg = theme.colors.base3,
    set_shape = function(cr, width, height)
      gears.shape.powerline(cr, width, height, (height / 2) * (-1))
    -- gears.shape.transform(shape.powerline) : translate(0, 25) (cr,width,height, (height / 2 ) * - 1)
    end,
    widget = wibox.container.background
  },
  left   = 0,
  right  = -13,
  top    = 0,
  bottom = 0,
  widget = wibox.container.margin
}

-- Виджет погоды
widgets.weather = wibox.widget.textbox()
awful.spawn.easy_async('cat '..os.getenv("HOME")..'/.config/awesome/scripts/weather.txt',
                                                    function(stdout) widgets.weather:set_text(stdout) end)
weathertimer = timer({ timeout = 650 })
weathertimer:connect_signal("timeout", function() awful.spawn.easy_async('cat '..os.getenv("HOME")..'/.config/awesome/scripts/weather.txt',
                                                    function(stdout) widgets.weather:set_text(stdout) end) end)
weathertimer:start()


-- Виджет батареи
widgets.battery = wibox.widget.textbox()
vicious.register(widgets.battery, vicious.widgets.bat,"$1$2%<span color='green'>($3/$4%)</span>", 5, "BAT0")

local widget = widgets.battery
widget:connect_signal("mouse::enter", function()
  notification = naughty.notify({
            text = vicious.call(vicious.widgets.bat, "Оставшееся время: $3\nУровень износа: $4%\nТекущая нагрузка: $5W", "BAT0"),
            timeout = 0,
            hover_timeout = 0.5,
        })
end)
widget:connect_signal("mouse::leave", function()
  naughty.destroy(notification)
  notification = nil
end)

-- Виджет произвольного текста
function widgets.text(text)
  wi = wibox.widget.textbox()
  wi:set_text(text)
  return wi
end


-- CPU
widgets.cpu = wibox.widget.textbox()
vicious.register(widgets.cpu, vicious.widgets.cpu, "CPU: $1%", 8)

-- MEM
widgets.mem = wibox.widget.textbox()
vicious.register(widgets.mem, vicious.widgets.mem, "MEM: $1%", 7)

-- SWAP
widgets.swap = wibox.widget.textbox()
vicious.register(widgets.swap, vicious.widgets.mem, "SWAP: $5%", 6)

-- HDD TEMP
widgets.hddtemp = wibox.widget.textbox()
vicious.register(widgets.hddtemp, vicious.widgets.hddtemp, "HDDTEMP:${/dev/sda}°C", 21)

-- SYS TEMP
widgets.systemp = wibox.widget.textbox()
vicious.register(widgets.systemp, vicious.widgets.thermal, "SYSTEMP:$1°C", 18, { "thermal_zone0", "sys"})

return widgets