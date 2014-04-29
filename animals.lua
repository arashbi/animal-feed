-- animal.lua
local animals = {}
local transition = require("transition")
require("animal")
animals.animals = {}
animals.createAnimal = function ()
	local sheep = Sheep:New(480,245)
	sheep.accepts = false
	local head = display.newCircle( 465, 235, 0)
	head.isHead = true
	physics.addBody( head, "dynamic", {density=0.1, friction=0.1, bounce=0.4, radius = 20 } )
	physics.addBody( sheep.group, "kinematic", {density=0.1, friction=0.1, bounce=0, shape ={-20,10,25,10,25,30,-20,30} } )
	physics.newJoint( "weld", head,sheep, head.x,head.y )
	-- transition.to(sheep.group,{time = 15000, x = 0})
	table.insert( animals.animals, sheep )
end
function animals.update(event,view)
	for _,v in pairs( animals.animals ) do 
		v:act(1)
	end
end

return animals