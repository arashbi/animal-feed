--Animal
Animal = {}
Animal.type = "ANIMAL"
Animal.IDLING = 1
Animal.WALKING = 2
Animal.EATING = 3
function Animal:New(x,y)
	local animal = display.newGroup()
	animal.state = 1
	setmetatable( animal, self )
	print('setting animal x to ',x)
	animal.x= x
	animal.y= y
	self.__index = self
	print ( 'setting up the timer ' .. system.getTimer())
	timer.performWithDelay(1000, animal )
	return animal
end

function Animal:_newStatus()
	if self.state == Animal.IDLING then
		self.state = Animal.WALKING
	else
		self.state = Animal.IDLING
	end
end

function Animal:_animate()
	if not self:getAnimation().isPlaying then
		-- self:getAnimation():play()
	end
	if self.state == Animal.WALKING then 
		self.x = self.x + 1.5
		self.group.x = self.x
	end
end
function Animal:timer(event)
	if math.random() > 0.1 then
		print("changing the status" .. system.getTimer( ))
		print ( "animal id " )
		print ( self)
		print (self.type)
		self:_newStatus()
		print( "changed to " .. self.state)
		self.animation:removeSelf( )
		self.group:remove(self.animation)
		self.animation = self:getAnimation()
		if self.timerObject then
			timer.cancel(self.timerObject)
			self.timerObject = nil
		end
		self.timerObject = timer.performWithDelay( math.random(500,2000), self )

	end
end


function Animal:act()
	-- if  self.timerObject then 
	-- 	for i,v in pairs(self.timerObject) do
	-- 		print (i)
	-- 		print(v)
	-- 	end
		
	-- end
	self:_animate()
end

Sheep = Animal:New()
function Sheep:New(x,y)
	local sheep = Animal:New(x,y)
	setmetatable(sheep, self)
	self.__index = self
	self.group = display.newGroup()
	self.group.x = x
	self.group.y = y
	self.animation = self:getAnimation()
	self.animation.x = 0
	self.animation.y = 0
	self.group:insert(self.animation)
	print "creating sheep finished"
	return sheep
end
function Sheep:getAnimation()
	if self.state == Animal.WALKING then
		return display.newImage(self.group,"sheep-1.png")
	elseif self.state == Animal.EATING then
			return display.newImage(self.group,"sheep-1.png")
	elseif self.state == Animal.IDLING then 
		return display.newImage(self.group,"sheep.png")
	end
	print("nothing matched")
end
function Animal.newSheep(x,y)
	local sheep = Sheep:New(x,y)
	return sheep
end
