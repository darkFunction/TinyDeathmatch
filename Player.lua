require ("Actor")
require ("class")

Player = inheritsFrom(Actor)
Player.SPEED = 160
Player.JUMP_POWER = 400

function Player:update(dt)
	self:checkCollisions()

	self.position.x = self.position.x + self.velocity.x * dt
	self.position.y = self.position.y + self.velocity.y * dt	
end

function Player:checkCollisions()
	-- ground
	local groundH = love.graphics.getHeight() - 60
	if self.position.y > groundH then
		self.position.y = groundH
		self.velocity.y = 0
		self.jumping = false
	end
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
	if not self.jumping then
		self.velocity.y = -self.JUMP_POWER
		self.jumping = true
	end
end

function Player:getBBox()
	return self.position.x + 12, self.position.y + 9, 24, 39
end
