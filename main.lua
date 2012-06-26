require("World")
require("Renderer")

function love.load()
	love.graphics.setBackgroundColor(148,205,255)
	Assets:load()
end

function love.update(dt)
	World:update(dt)
	Player:update(dt)
end

function love.draw()
	Renderer:render(World)
end

function love.keypressed(key, unicode)
end

