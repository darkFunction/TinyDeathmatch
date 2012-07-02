require ("Actor")
require ("class")

Player = {}
setmetatable(Player, {__index = Actor})
Player.SPEED = 180
Player.JUMP_POWER = 600
Player.type = "Player"
Player.size = {w = 48, h = 48}

local function sign(x)
	return x < 0 and -1 or (x>0 and 1 or 0)
end

function Player:update(dt)
	self.onPlatform = nil -- will be updated

	-- screen wrap
	local w = self.size.w
	if self.position.x < 0-w then 
		self.position.x = love.graphics.getWidth()
	elseif self.position.x > love.graphics.getWidth() then
		self.position.x = 0-w
	end

	-- apply velocity
	if self.velocity.y > 540 then self.velocity.y = 540 end
	self.position.x = self.position.x + self.velocity.x * dt
	self.position.y = self.position.y + self.velocity.y * dt
end

function Player:collision(item, dx, dy)
	if item.type == "Player" then
		if self.position.y < item.position.y and self.velocity.y > 0 then
			item:explode()	
			self.velocity.y = -self.JUMP_POWER
		end
	end

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

function Player:explode()
	local x,y,w,h = self:getBBox()
	World:bloodExplosion(x+w/2, y+(h/2)-5)

	self.position.x = 200
	self.position.y = 200
	self.velocity.x = 0
	self.velocity.y = 0
end
