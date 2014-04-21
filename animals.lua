-- animal.lua
local animals = {}
local transition = require("transition")
animals.animals = {}
animals.createAnimal = function ()
	local sheep = display.newImage("sheep.png", 480,245)
	sheep.accepts = false
	local head = display.newCircle( 465, 235, 2)
	head.isHead = true
	physics.addBody( head, "dynamic", {density=0.1, friction=0.1, bounce=0.4, radius = 20 } )
	physics.addBody( sheep, "kinematic", {density=0.1, friction=0.1, bounce=0, shape ={-20,10,25,10,25,30,-20,30} } )
	physics.newJoint( "weld", head,sheep, head.x,head.y )
	sheep.acceptingPicture = "sheep-1.png"
	table.insert( animals.animals, sheep )
end
function animals.update(view)
	for _,v in pairs( animals.animals ) do 

		if  not v.isDisplayed then
			view:insert(v)
			-- transition.moveTo( v, {time = 1500, x = 0} )
		end
		v.x = v.x - 1.5
	end
end
return animals