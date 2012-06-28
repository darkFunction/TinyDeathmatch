require("World")
require("Renderer")
require("Input")
require("TiledMapLoader")

function love.load()
	love.graphics.setBackgroundColor(148,205,255)
	Assets:load()
	TiledMap_Load("assets/Level1.tmx", nil, nil, "assets/")
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
