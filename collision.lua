--collisions
local collisions = {}
collisions.onCollision = function (event)

	if "began" == event.phase then
		if fruitAndHead(event) then
			if event.object1.isFruit then
				event.object1:removeSelf( )
			else
				event.object2:removeSelf( )
			end 

		end
		if event.object1.isFruit or event.object2.isFruit then
			-- print " a fruit collide with something"
			
		end
	end
end

function fruitAndHead(event)
	local obj1 = event.object1
	local obj2 = event.object2
	local result;
	if ( obj1.isFruit and obj2.isHead ) or 
		(obj2.isFruit and obj1.isHead) then
		result = true
	end
	return result
end
return collisions