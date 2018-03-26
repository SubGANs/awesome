-- {{{ Хоткеи mute, volume +, volume -
K_Mute = "#121"
K_VolUp = "#123"
K_VolDown = "#122"
-- }}}
  

-- {{{ Кнопки панели NumLock
Num0 = "#90"
Num1 = "#87"
Num2 = "#88"
Num3 = "#89"
Num4 = "#83"
Num5 = "#84"
Num6 = "#85"
Num7 = "#79"
Num8 = "#80"
Num9 = "#81"

function NumLockKeys(x)
  if x == 1 then
    return Num1
  elseif x == 2 then
    return Num2
  elseif x == 3 then
    return Num3
  elseif x == 4 then
    return Num4
  elseif x == 5 then
    return Num5
  elseif x == 6 then
    return Num6
  elseif x == 7 then
    return Num7
  elseif x == 8 then
    return NUm8
  elseif x == 9 then
    return Num9
  elseif x == 0 then
    return Num0
  end
end
-- }}}

-- Поиск кодов клавиш:
-- xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'

-- {{{ Key bindings
globalkeys = gears.table.join(
      -- Мои бинды
    awful.key({}, K_VolDown, function () awful.util.spawn("sh -c 'pactl set-sink-mute 0 false ; pactl set-sink-volume 0 -2%'") end,
              {description = "Убавить громкость", group = "sound"}), -- убавить громкость на 5%
    awful.key({}, K_VolUp, function () awful.util.spawn("sh -c 'pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +2%'") end,
              {description = "Прибавить громкость", group = "sound"}),-- прибавить громкость на 5%
    awful.key({}, K_Mute, function () awful.util.spawn("pactl set-sink-mute 0 toggle") end,
              {description = "Отключить звук", group = "sound"}),--mute

    awful.key({ modkey,  "Shift"  }, "p", function () awful.util.spawn(file_manager) end,
              {description = "Файловый менеджер", group = "program"}),
    awful.key({ modkey,           }, "c", function () awful.util.spawn("galculator") end,
              {description = "Калькулятор", group = "program"}),
    awful.key({ modkey,           }, "e", function () awful.util.spawn(geditor) end,
              {description = "Sublime Text", group = "program"}),
    awful.key({ modkey,           }, "b", function () awful.util.spawn(browser) end,
              {description = "Chromium", group = "program"}),

    awful.key({ modkey,           }, "\\", function () awful.util.spawn(awful.util.getdir("config").."/scripts/i3lock_pix.sh") end,
              {description = "Заблокировать экран", group = "system"}), --lock notebook
    awful.key({ modkey,           }, "F9", function () awful.util.spawn(awful.util.getdir("config").."/scripts/touch_on_off.sh") end,
              {description = "Влючение/Отключение тачпада", group = "system"}),--отключить тачпад
    awful.key({}, "Print", function () awful.util.spawn(awful.util.getdir("config").."/scripts/screen_all.sh") end,
              {description = "Скриншот экрана", group = "screen"}), -- скриншот экрана
    awful.key({ modkey,           }, "Print", function () awful.util.spawn(awful.util.getdir("config").."/scripts/screen_window.sh") end,
              {description = "Скриншот выделенной области", group = "screen"}), -- скриншот выделенной области
    awful.key({}, "F5", function () awful.util.spawn("sudo"..awful.util.getdir("config").."/scripts/backlight_up.sh") end,
              {description = "Повысить яркость", group = "system"}), -- повысить яркость
    awful.key({}, "F6", function () awful.util.spawn("sudo"..awful.util.getdir("config").."/scripts/backlight_down.sh") end,
              {description = "Понизить яркость", group = "system"}), -- понизить яркость

    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () screen.primary.mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = screen.primary.mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Перейти на тег с помощью NumLock
        awful.key({ modkey }, NumLockKeys(i),
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end),
                  --{description = "view tag #"..i.." with Numlock", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
                -- Переместить клинета на тэг с помощью NumLock
        awful.key({ modkey, "Shift" }, NumLockKeys(i),
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end),
                  --{description = "move focused client to tag # with NumLock"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end



-- Set keys
root.keys(globalkeys)
-- }}}