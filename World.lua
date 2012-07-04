require ("Player")
local bump = require("bump")
require("TiledMapLoader")

World = {}

World.GRAVITY = 1600
local NUM_CLOUDS = 6
World.actors = {}
World.effects = {}
World.clouds = {}

function World:load()
	
	self.player1 = self:newPlayer(400, 20)
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
				bump.add( self:newPlatform(x, y) )

				-- add extras at side for when char is slightly offscreen
				if x == TiledMap_GetMapW()-1 then
					bump.add( self:newPlatform(x+1,y) )
				elseif x == 0 then
					bump.add( self:newPlatform(x-1,y) )
				end
			end
			if platform ~= nil then bump.add(platform) end
		end
	end

	for i=0,NUM_CLOUDS do 
		self:newCloud(false)
	end

end

function World:newCloud(offscreen)
	local size = 0.5 + math.random()
	local sx =  math.random(love.graphics.getWidth())
	if offscreen then 
		sx = love.graphics.getWidth()
	end
	local cloud = {
		x = sx,
		y = -(size/2) + math.random(120),
		scale = size,
		speed = -(size*size*30),
		flip = (math.random(2)==1),
		width = Assets.imageCloud:getWidth()*size
	}
	self.clouds[cloud] = true
	return cloud
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
	if item1.type == "Player" or item2.type == "Player" then return true end
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

	for effect,b in pairs(self.effects) do
		effect:update(dt)
		if effect:isEmpty() then self.effects[effect] = nil end
	end

	local remove = {}
	for cloud,b in pairs(self.clouds) do
		cloud.x = cloud.x + cloud.speed*dt;
		if cloud.x < -cloud.width then
			table.insert(remove,cloud)
			self:newCloud(true)
		end
	end
	for i,cloud in ipairs(remove) do
		self.clouds[cloud] = nil
	end

end

function World:bloodExplosion(x, y)
	local image = love.graphics.newImage("assets/blood.png")
	local effect = love.graphics.newParticleSystem(image, 200)
	self.effects[effect] = true
	effect:setPosition(x,y)
	effect:setParticleLife(0.1,0.5)
	effect:setSpeed(20,200)
	effect:setSizes(1.7,0.5)
	effect:setEmissionRate(4500)
	effect:setLifetime(0.1)
	effect:setSpread(50)
	effect:setSpin(0,5,1)
	effect:setGravity(self.GRAVITY/5)
	effect:start()
end
