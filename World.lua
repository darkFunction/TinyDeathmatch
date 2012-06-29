require ("Player")
local bump = require("bump")
require("TiledMapLoader")

World = {}
World.player = Player:new()
World.player.position.x = love.graphics.getWidth() / 2
World.player.position.y = love.graphics.getHeight() - 70
World.GRAVITY = 14

function World:load()
	TiledMap_Load("assets/Level1.tmx", nil, nil, "assets/")
	
	bump.initialize(kTileSize)
	bump.add(self.player)

	for x=1, TiledMap_GetMapW() do
		for y=1, TiledMap_GetMapH() do
			local tile = TiledMap_GetMapTile(x, y, 2)
			if tile ~= kMapTileTypeEmpty then
				local platform = self:newPlatform(x, y)
					bump.add(platform)
					--print("adding platform:", platform.getBBox())
			end
		end
	end
end

function World:newPlatform(x, y)
	local p= {
		l=kTileSize * x,
		t=kTileSize * y, 
		w=kTileSize, 
		h=kTileSize
	}
	p.getBBox = function() return p.l, p.t, p.w, p.h end
	return p
end

function bump.collision()
end

function bump.shouldCollide(item1, item2)
	if item1 == World.player then return true end
	return false
end

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

	bump.collide()
end
