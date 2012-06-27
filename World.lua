require ("Player")

World = {}
World.player = Player:new()
World.player.position.x = love.graphics.getWidth() / 2
World.player.position.y = love.graphics.getHeight() - 70
World.GRAVITY = 14

function World:update(dt)
	
	runAnim = Assets.animPlayerRun
	if self.player.velocity.x ~= 0 then
		runAnim:update(dt)
	else
		last = runAnim:getSize()
		if runAnim.position ~= last then
			runAnim:seek(last)
		end
	end

	-- gravity
	self.player.velocity.y = self.player.velocity.y + self.GRAVITY
	self.player:update(dt)
end
