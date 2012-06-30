require ("AnAL")
require ("Assets")
require ("TiledMapLoader")
local bump_debug = require ("bump_debug")

Renderer = {}

function Renderer:render(world)
	
	TiledMap_DrawNearCam(love.graphics.getWidth()/2, love.graphics.getHeight()/2)

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
