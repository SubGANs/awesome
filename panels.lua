local icon_button = require("icon_button")
local widgets = require("widgets")


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Верхняя панель
awful.screen.connect_for_each_screen(function(s)
  -- Показываем всю инфу на основном мониторе
  if s == screen.primary then
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    layouts = awful.layout.layouts
    tags = {
      name = { "☭", "⌥", "✇", "⌤", "☼" },
      layout = {awful.layout.layouts[1], awful.layout.layouts[6], awful.layout.layouts[1], awful.layout.layouts[6], awful.layout.layouts[1]}
    }
    tags[s] = awful.tag(tags.name, s, tags.layout)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s})
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --mylauncher,
            s.mytaglist,
            widgets.text("  "),
            icon_button.firefox,
            icon_button.subl,
            icon_button.terminal,
            icon_button.chromium,
            icon_button.filemgr,
            widgets.text("  "),
            s.mypromptbox,
            widgets.text("  "),
            widgets.cpu,
            widgets.text("  "),
            widgets.mem,
            widgets.text("  "),
            widgets.swap,
            widgets.text("  "),
            widgets.hddtemp,
            widgets.text("  "),
            widgets.systemp,
        },
        {
          layout = wibox.layout.fixed.horizontal,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            widgets.weather,
            widgets.systray,
            widgets.keyboardlayout,
            widgets.textclock,
            widgets.alarm,
            s.mylayoutbox,
        }
    }
  else
    -- Wallpaper
    set_wallpaper(s)
    -- Each screen has its own tag table.
    awful.tag({ "☭" }, s, awful.layout.layouts[1])
    s.mywibox = awful.wibar({ position = "top", screen = screen.primary, height = 7, bg = theme.colors.base3 })
  end
end)

-- Вторая верхняя панель (просто другого цвета, ничего на ней нет)
awful.screen.connect_for_each_screen(function(s)
  if s == screen.primary then
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = screen.primary, height = 1, bg = theme.colors.base3 })
  end
end)

-- Нижняя панель
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {layout = wibox.layout.fixed.horizontal,},
        s.mytasklist, -- Middle widget
        {layout = wibox.layout.fixed.horizontal,},
    }
end)
-- }}}