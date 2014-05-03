-- animal.lua
local animals = {}
local transition = require("transition")
require("animal")
animals.animals = {}
animals.createAnimal = function ()
	local sheep = Sheep:New(480,245)
	
	-- transition.to(sheep.group,{time = 15000, x = 0})
	table.insert( animals.animals, sheep )
end
function animals.update(event,view)
	for _,animal in pairs( animals.animals ) do 
		animal:act(1)
	end
end

return animals