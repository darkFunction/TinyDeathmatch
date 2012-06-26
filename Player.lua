require ("Actor")
require ("class")

Player = inheritsFrom(Actor)

function Player:update(dt)
	local kb = love.keyboard

	if kb.isDown("right") then
		self.position.x = self.position.x + 100*dt
	elseif kb.isDown("left") then
		self.position.x = self.position.x - 100*dt
	end
end
