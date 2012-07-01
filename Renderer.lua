require ("AnAL")
require ("Assets")
require ("TiledMapLoader")
local bump_debug = require ("bump_debug")

Renderer = {}
local canvas = nil
local screenW = love.graphics.getWidth()
local screenH = love.graphics.getHeight()

function Renderer:init()
	canvas = love.graphics.newCanvas()
	love.graphics.setCanvas(canvas)

	love.graphics.draw(Assets.bg, 0, 0)
	TiledMap_DrawNearCam(screenW/2, screenH/2)
	self:drawGrid(fb)

	love.graphics.setColor(255,255,255)
	love.graphics.setCanvas()
end

function Renderer:update(dx)
	
end

function Renderer:render(world)

	love.graphics.draw(canvas, 0, 0)

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

	-- debug
	--bump_debug.draw(0,0,800,600)
end

function Renderer:drawGrid()
	local size = kTileSize
	local pad = 5

	for x=0,screenW-size/2,size do
		for y=0,screenH-size/2,size do
			r,g,b,a = Assets.bgData:getPixel(x+size/2,y+size/2)
			love.graphics.setColor(255,255,255,math.random(50))
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
