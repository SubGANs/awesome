-- {{{ Rules
-- Команда для поиска названия окна - "xprop | grep -i class"
-- Команда для поиска производных главного окна - "xprop | grep -i role"
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.centered --+awful.placement.no_offscreen+awful.placement.no_overlap,
      }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer",
        },

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
        },
        properties = { 
          floating = true,
          placement = awful.placement.centered
        }
      },

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },
    { rule = { class = { "Guake" },
      properties = { 
        floating = true,
        size_hints_honor = false
      }, 
      callback = awful.client.setslave,}
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
    { rule = { class = "Audacious" },
        properties = { tag = "⌥" } },
    { rule = { class = "Subl3" },
     properties = { tag = "☼" } },
    { rule = { class = "Thunderbird" },
     properties = { tag = "⌤" } },
}
-- }}}