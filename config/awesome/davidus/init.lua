---------------------------------------------------
-- Personal stuff for the awesome window manager
---------------------------------------------------

-- {{{ Setup environment
local language = "us" -- [DEPRECATED]

local spawn
local gears
local naughty
local beautiful

local davidus = {}
local sound = {}
-- }}}


function davidus.init(_spawn, _gears, _naughty, _beautiful)
    spawn     = _spawn
    gears     = _gears
    naughty   = _naughty
    beautiful = _beautiful
end

-- {{{ [DEPRECATED] Change keyboard layout
function davidus.kbdmap_swap(widget)
	if language == "us" then
		language = "fr"
	else
		language = "us"
	end

	spawn("setxkbmap " .. language)
	widget:set_markup(" <b>" .. language .. "</b>  ")
end
-- }}}

-- {{{ Sound control
function davidus.sound_init(forcer, widget)
	sound.update = forcer
	sound.widget = widget
end

local function sound_update()
	sound.update( { sound.widget } )
end

function davidus.sound_mute()
	spawn("swapmute")
	sound_update()
end

function davidus.sound_down()
	spawn("amixer set Master unmute 1%-")
	sound_update()
end

function davidus.sound_up()
	spawn("amixer set Master unmute 1%+")
	sound_update()
end
-- }}}

-- {{{ Multiple screen
-- (http://awesome.naquadah.org/wiki/Using_Multiple_Screens#Cycling_through_possible_configurations)

-- Get active outputs
local function outputs()
   local outputs = {}
   local xrandr = io.popen("xrandr -q")
   if xrandr then
      for line in xrandr:lines() do
	 output = line:match("^([%w-]+) connected ")
	 if output then
	    outputs[#outputs + 1] = output
	 end
      end
      xrandr:close()
   end

   return outputs
end

local function arrange(out)
   -- We need to enumerate all the way to combinate output. We assume
   -- we want only an horizontal layout.
   local choices  = {}
   local previous = { {} }
   for i = 1, #out do
      -- Find all permutation of length `i`: we take the permutation
      -- of length `i-1` and for each of them, we create new
      -- permutations by adding each output at the end of it if it is
      -- not already present.
      local new = {}
      for _, p in pairs(previous) do
	 for _, o in pairs(out) do
	    if not gears.table.hasitem(p, o) then
	       new[#new + 1] = gears.table.join(p, {o})
	    end
	 end
      end
      choices = gears.table.join(choices, new)
      previous = new
   end

   return choices
end

-- Build available choices
local function menu()
   local menu = {}
   local out = outputs()
   local choices = arrange(out)

   for _, choice in pairs(choices) do
      local cmd = "xrandr"
      -- Enabled outputs
      for i, o in pairs(choice) do
	 cmd = cmd .. " --output " .. o .. " --auto"
	 if i > 1 then
	    cmd = cmd .. " --right-of " .. choice[i-1]
	 end
      end
      -- Disabled outputs
      for _, o in pairs(out) do
	 if not gears.table.hasitem(choice, o) then
	    cmd = cmd .. " --output " .. o .. " --off"
	 end
      end

      local label = ""
      if #choice == 1 then
	 label = 'Only <span weight="bold">' .. choice[1] .. '</span>'
      else
	 for i, o in pairs(choice) do
	    if i > 1 then label = label .. " + " end
	    label = label .. '<span weight="bold">' .. o .. '</span>'
	 end
      end

      menu[#menu + 1] = { label,
			  cmd,
                          "/usr/share/icons/Tango/32x32/devices/display.png"}
   end

   return menu
end

-- Display xrandr notifications from choices
local state = { iterator = nil,
		timer = nil,
		cid = nil }

function davidus.xrandr()
   -- Stop any previous timer
   if state.timer then
      state.timer:stop()
      state.timer = nil
   end

   -- Build the list of choices
   if not state.iterator then
      state.iterator = gears.table.iterate(menu(),
					function() return true end)
   end

   -- Select one and display the appropriate notification
   local next  = state.iterator()
   local label, action, icon
   if not next then
      label, icon = "Keep the current configuration", "/usr/share/icons/Tango/32x32/devices/display.png"
      state.iterator = nil
   else
      label, action, icon = unpack(next)
   end
   state.cid = naughty.notify({ text = label,
				icon = icon,
				timeout = 4,
				screen = mouse.screen, -- Important, not all screens may be visible
				font = "Free Sans 18",
				replaces_id = state.cid }).id

   -- Setup the timer
   state.timer = timer { timeout = 4 }
   state.timer:connect_signal("timeout",
			  function()
			     state.timer:stop()
			     state.timer = nil
			     state.iterator = nil
			     if action then
				 spawn(action, false)
			     end
			  end)
   state.timer:start()
end
-- }}}

-- {{{ Low battery watcher
local function batteryInfo(adapter)
     spacer = " "
     local fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")
     local fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
     local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
     local cur = fcur:read()
     local cap = fcap:read()
     local sta = fsta:read()
     local battery = math.floor(cur * 100 / cap)
     if sta:match("Discharging") then
         if tonumber(battery) < 15 then
             naughty.notify({ title      = "Battery Warning"
                            , text       = "Battery low!"..spacer..battery.."%"..spacer.."left!"
                            , timeout    = 5
                            , position   = "top_right"
                            , fg         = beautiful.fg_focus
                            , bg         = beautiful.bg_focus
                            })
         end
     end
     fcur:close()
     fcap:close()
     fsta:close()
 end

function davidus.start_battery_watcher()
    battery_timer = timer({timeout = 20})
    battery_timer:connect_signal("timeout", function()
        batteryInfo("BAT0")
    end)
    battery_timer:start()
end
-- }}}


return davidus
