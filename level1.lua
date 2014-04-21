--------------------------------------------------------------------------------
--------- -- -- level1.lua -- --------------------------------------------------
---------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local fruits = require("fruit")
local animals = require("animals")
-- include Corona's "physics" library
local physics = require ("physics")

physics.start(); physics.pause()
-- physics.setDrawMode("hybrid")
--------------------------------------------
physics.setGravity(0,30)
-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local dragStart,dragEnd
local pusks

 function createSky()
	local sky = display.newImage("sky.jpg", screenW,64)
	physics.addBody( sky, "static", {density=0, friction=0.1, bounce=0  } )
	sky.x = screenW/2
	sky.y = 0
	return sky
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- create a grey rectangle as the backdrop
	local background = display.newRect( 0, 0, screenW, screenH )
	background.anchorX = 0
	background.anchorY = 0
	background:setFillColor(0,1,0)
	-- make a crate (off-screen), position it, and rotate slightly
	local sky = createSky()
	-- create a grass object and add physics (with custom shape)
	local grass = display.newImageRect( "grass.png", screenW, 80)
	grass.anchorX = 0
	grass.anchorY = 1
	grass.x, grass.y = 0, display.contentHeight
	grass.name = "grass"
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local grassShape = { -halfW,-5, halfW,-5, halfW,34, -halfW,34 }
	physics.addBody( grass, "static", { friction=0.3, shape=grassShape } )
	animals.createAnimal()
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert(sky)
	sceneGroup:insert( grass)
	
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end


------
function touch(event)
	local phase = event.phase
	if "began" == phase then
		print("touch begin")
		dragStart = {}
		dragStart.x = event.x
		dragStart.y = event.y
	end
	if "ended" == phase then
		print("touch end phase")
		if dragStart then
			dragEnd = {}
			dragEnd.x = event.x
			dragEnd.y = event.y
		end
	end
end
---------------------------------------------------------------------------------

function scene:enterFrame(event)
	fruits.refreshScene(self.view)
	animals.update(self.view)
	if dragStart and dragEnd then
		print "casting a ray"
		local hits = physics.rayCast( dragStart.x,dragStart.y, dragEnd.x,dragEnd.y)
		if hits then
			for i, v in ipairs(hits) do
				print ("hit ", i ,v.object.isFruit)
				for key,value in pairs(v) do print(key,value) end
				if v.object.isFruit then
					fruits.removePusk(v.object)	
					print ( 'fruit touched')
				end
			end
		end
		dragStart = nil
		dragEnd = nil
	end
end
print("setting up event handlers")
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
Runtime:addEventListener( "touch", touch )
Runtime:addEventListener("enterFrame", scene)
local collisions = require("collision")
Runtime:addEventListener("collision",collisions.onCollision)
-----------------------------------------------------------------------------------------

return scene