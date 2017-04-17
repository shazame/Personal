---------------------------------------------------
-- Personal stuff for the awesome window manager
---------------------------------------------------

-- {{{ Setup environment
local language = "us"
local launch

local davidus = {}
local sound = {}
-- }}}


-- {{{ Local functions
-- }}}


-- {{{ Global functions
function davidus.init(launcher)
	launch = launcher
end

-- {{{ Change keyboard layout
function davidus.kbdmap_swap(widget)
	if language == "us" then
		language = "fr"
	else
		language = "us"
	end

	launch("setxkbmap " .. language)
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
	launch("swapmute")
	sound_update()
end

function davidus.sound_down()
	launch("amixer set Master unmute 1%-")
	sound_update()
end

function davidus.sound_up()
	launch("amixer set Master unmute 1%+")
	sound_update()
end
-- }}}

return davidus

-- }}}
