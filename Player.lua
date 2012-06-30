require ("Actor")
require ("class")

Player = {}
setmetatable(Player, {__index = Actor})
Player.SPEED = 180
Player.JUMP_POWER = 500

local function sign(x)
	return x < 0 and -1 or (x>0 and 1 or 0)
end

function Player:update(dt)
	self.onPlatform = nil -- will be updated

	self.position.x = self.position.x + self.velocity.x * dt
	self.position.y = self.position.y + self.velocity.y * dt
end

function Player:collision(item, dx, dy)
	self.position.y = self.position.y + dy
	self.position.x = self.position.x + dx

	if dy~=0 and sign(self.velocity.y) ~= sign(dy) then
		self.velocity.y = 0
		if dy < 0 then 
			self.onPlatform = item 
		end
	end
	if dx and sign(self.velocity.x) ~= sign(dx) then self.velocity.x = 0 end
end

function Player:moveLeft()
	self.velocity.x = -self.SPEED
	self.facing = "left"
end

function Player:moveRight()
	self.velocity.x = self.SPEED
	self.facing = "right"
end

function Player:jump()
	if self.onPlatform then
		self.velocity.y = -self.JUMP_POWER
		self.onPlatform = nil
	end
end

function Player:getBBox()
	return self.position.x + 16, self.position.y + 10, 16, 38
end
