require ("Player")
local bump = require("bump")
require("TiledMapLoader")

World = {}

World.GRAVITY = 1000
World.actors = {}

function World:load()
	
	self.player1 = self:newPlayer(love.graphics.getWidth()/2, love.graphics.getHeight()-90)
	self.player2 = self:newPlayer(200,20)
	table.insert(self.actors, self.player1)
	table.insert(self.actors, self.player2)

	TiledMap_Load("assets/Level1.tmx", nil, nil, "assets/")
	
	bump.initialize(kTileSize)
	for i,player in ipairs(self.actors) do
		bump.add(player)
		Assets:addAnimation(player, "run")
	end

	for x=0, TiledMap_GetMapW() do
		for y=0, TiledMap_GetMapH() do
			local tile = TiledMap_GetMapTile(x, y, 1)
			if tile ~= kMapTileTypeEmpty then
				local platform = self:newPlatform(x, y)
					bump.add(platform)
					--print("adding platform:", platform.getBBox())
			end
		end
	end
end

function World:newPlayer(x, y)
	local p = Player:new()
	p.position.x = x;
	p.position.y = y;
	return p
end

function World:newPlatform(x, y)
	local p= {
		l=kTileSize * x,
		t=kTileSize * y, 
		w=kTileSize, 
		h=kTileSize
	}
	p.getBBox = function() return p.l, p.t, p.w, p.h end
	p.collision = function(self, item, dx, dy) end
	p.type = "Platform"
	return p
end

function bump.collision(item1, item2, dx, dy)
	item1:collision(item2, dx, dy)
	item2:collision(item1, -dx, -dy)
end

function bump.shouldCollide(item1, item2)
	if item1.type == "Actor" or item2.type == "Actor" then return true end
	return false
end

function World:update(dt)
	
	for i,player in ipairs(self.actors) do
		local runAnim = Assets.animations[player]["run"]
		if player.velocity.x ~= 0 then
			runAnim:update(dt)
		else
			last = runAnim:getSize()
			if runAnim.position ~= last then
				runAnim:seek(last) -- stand
			end
		end

		-- gravity
		player.velocity.y = player.velocity.y + self.GRAVITY*dt
		player:update(dt)
	end	

	bump.collide()
end
