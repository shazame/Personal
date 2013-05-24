---------------------------------------------------
-- Personal stuff for the awesome window manager
---------------------------------------------------

-- {{{ Setup environment
local language = "us"

local davidus = {}
-- }}}


-- {{{ Local functions
-- }}}


-- {{{ Global functions
-- {{{ Change keyboard layout
function davidus.kbdmap_swap(widget, launch)
	if language == "us" then
		language = "fr"
	else
		language = "us"
	end

	launch("setxkbmap " .. language)
	widget:set_markup(" <b>" .. language .. "</b>  ")
end
-- }}}

return davidus

-- }}}
