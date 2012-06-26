require ("Player")

World = {}
World.player = Player:new()
World.player.position.x = love.graphics.getWidth() / 2
World.player.position.y = love.graphics.getHeight() - 70

function World:update(dt)
	Assets.animPlayerRun:update(dt)
end
