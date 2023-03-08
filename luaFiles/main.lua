-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

local cut1_sound
local cut6_sound

local stage1_clear = 0
local stage2_clear = 0
local stage3_clear = 0
local stage4_clear = 0

-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "start" )
end

onFirstView()	-- invoke first tab button's onPress event manually
