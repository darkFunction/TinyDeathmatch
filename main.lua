require("World")
require("Renderer")
require("Input")

function love.load()
	love.graphics.setBackgroundColor(148,205,255)
	Assets:load()
end

function love.update(dt)
	World:update(dt)
	Input:update(World)
end

function love.draw()
	Renderer:render(World)
end

function love.keypressed(key, unicode)
end
