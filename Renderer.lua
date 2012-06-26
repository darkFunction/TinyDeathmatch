require ("AnAL")
require ("Assets")

Renderer = {}

function Renderer:render(world)
	Assets.animPlayerRun:draw(world.player.position.x, world.player.position.y)	
end
