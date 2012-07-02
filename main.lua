require("World")
require("Renderer")
require("Input")

function love.load()
	love.graphics.setBackgroundColor(148,205,255)
	Assets:load()
	World:load()
	Renderer:init()
end

function love.update(dt)
	Input:update(World)
	World:update(dt)
	Renderer:update(dt)
end

function love.draw()
	Renderer:render(World)
end

function love.keypressed(key, unicode)

		--World:bloodExplosion(500,550)

end
