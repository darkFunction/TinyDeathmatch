require ("AnAL")
require ("Assets")
require ("TiledMapLoader")
local bump_debug = require ("bump_debug")

Renderer = {}
local bgCanvas = nil
local fgCanvas = nil
local screenW = love.graphics.getWidth()
local screenH = love.graphics.getHeight()

function Renderer:init()
	bgCanvas = love.graphics.newCanvas()
	fgCanvas = love.graphics.newCanvas()

	love.graphics.setCanvas(bgCanvas)
	love.graphics.draw(Assets.bg, 0, 0)
	self:drawGrid()

	love.graphics.setCanvas(fgCanvas)
	TiledMap_DrawNearCam(screenW/2, screenH/2)
	self:drawGrid()

	love.graphics.setCanvas()

end

function Renderer:update(dx)
	
end

function Renderer:render(world)

	love.graphics.draw(bgCanvas, 0, 0)

	for cloud,b in pairs(world.clouds) do
		love.graphics.setColor(255,255,255,180 - (cloud.scale*80))
		if not cloud.flip then
			love.graphics.draw(Assets.imageCloud, cloud.x, cloud.y, 0, cloud.scale, cloud.scale, 0, 0)
		else
			love.graphics.draw(Assets.imageCloud, cloud.x, cloud.y, 0, -cloud.scale, cloud.scale, Assets.imageCloud:getWidth(), 0)
		end
	end
	love.graphics.setColor(255,255,255,255) 

	love.graphics.draw(fgCanvas, 0, 0)
		
	for i,player in ipairs(world.actors) do
		local pPos = player.position
		local pAnim = Assets.animations[player]["run"]
		local pFaceRight = player.facing == "right"

		if player.onPlatform then
			if pFaceRight then
				pAnim:draw(pPos.x, pPos.y, 0, -1, 1, pAnim:getWidth(), 0)
			else 
				pAnim:draw(pPos.x, pPos.y, 0, 1, 1, 0, 0)
			end
		else
			local image = nil
			if player.velocity.y < 0 then 
				image = Assets.imagePlayerJump
			else 
				image = Assets.imagePlayerFall 
			end
			if pFaceRight then
				love.graphics.draw(image, pPos.x, pPos.y, 0, -1, 1, image:getWidth(), 0)
			else
				love.graphics.draw(image, pPos.x, pPos.y)
			end
		end
	end

	for effect,b in pairs(world.effects) do
		love.graphics.draw(effect)
	end

	-- debug
	--bump_debug.draw(0,0,800,600)
end

function Renderer:drawGrid()
	local size = kTileSize / 4
	local pad = 1

	for x=0,screenW-size/2,size do
		for y=0,screenH-size/2,size do
			r,g,b,a = Assets.bgData:getPixel(x+size/2,y+size/2)
			if TiledMap_GetMapTile(math.floor(x / kTileSize), math.floor(y / kTileSize), 1) == 0 then
				love.graphics.setColor(255,255,255,math.random(50)) 
			else 
				love.graphics.setColor(0,0,0,170+math.random(50))
			end
			love.graphics.rectangle(
				"fill", 
				x+pad, 
				y+pad, 
				size-pad*2, 
				size-pad*2)
		end
	end
	love.graphics.setColor(255,255,255)
end

--[[
function Renderer:updateGrid()

end

function Renderer:initGrid()
	if not grid then
		grid = {}
		gridMod = {}
		for x=0,screenW-size/2,size do
			grid[x] = {}
			gridMod[x] = {}
			for y=0,screenH-size/2,size do
				r,g,b,a = Assets.bgData:getPixel(x+size/2,y+size/2)
				rand = math.random(20) - 10
				r,g = r + rand, g+rand
				grid[x][y] = {r,g,b,a}
				gridMod[x][y] = 0
			end
		end

	end
end]]
