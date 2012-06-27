require ("AnAL")
require ("Assets")

Renderer = {}

function Renderer:render(world)
	
	player = world.player
	pPos = player.position
	pAnim = Assets.animPlayerRun
	pFaceRight = player.facing == "right"

	if not player.jumping then
		if pFaceRight then
			pAnim:draw(pPos.x, pPos.y, 0, -1, 1, pAnim:getWidth(), 0)
		else 
			pAnim:draw(pPos.x, pPos.y, 0, 1, 1, 0, 0)
		end
	else
		local image = Assets.imagePlayerJump
		if pFaceRight then
			love.graphics.draw(image, pPos.x, pPos.y, 0, -1, 1, image:getWidth(), 0)
		else
			love.graphics.draw(image, pPos.x, pPos.y)
		end
	end
end
