local  fruits = {}
fruits.fruits = {}
fruits.pusks = {}
fruits.puskJoints = {}

function fruits.removePusk(fruit)
	print("removing fruit pusk")
	print(fruit.isFruit)
	fruits.pusks[fruit]:removeSelf( )
	fruit.dropped = true
end

function displayedFruits()
	local counter = 0
	for _,fruit in pairs(fruits.fruits) do
		if fruit.isDisplayed then
			counter = counter + 1
		end
	end
	return counter
end
function fruits.addFruits(view)
	for i = 1,10 do
	 fruits.createFruit(view)
	end
end
function fruits.createFruit(view)
	local fruit = display.newImage( "blue.png" )
	fruit.y =  40
	fruit.x = math.random( 10,470)
	fruit.isFruit = true
	fruit.rotation = 15
	table.insert(fruits.fruits,fruit)
	-- add physics to the crate
	physics.addBody( fruit, { density=5.0, friction=0.2, bounce=0.3, radius = 15 } )
	local pusk = display.newCircle( fruit.x, fruit.y -10 , 2 )
	fruits.pusks[fruit] = pusk
	physics.addBody( pusk, "static", {density=0, friction=0.3, bounce=b, shape = {2,2,fruit.x, fruit.y -10} } )
	puskJoint = physics.newJoint( "pivot", pusk,fruit, fruit.x ,fruit.y-10 )
	fruits.puskJoints[fruit] = puskJoint
	view:insert(fruit)
	fruit.isDisplayed = true;
end

function fruits.refreshScene(view)
	-- print "refreshing the scene"
	if math.random( ) > 0.95 then
		fruits.createFruit()
	end
	if fruit.isDropped then 
	end
end
return fruits