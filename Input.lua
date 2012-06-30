Input = {}
function Input:update(world)
	local kb = love.keyboard

	local player = world.player1
	
	if kb.isDown("right") then
		player:moveRight()	
	elseif kb.isDown("left") then
		player:moveLeft()	
	else
		player.velocity.x = 0;
	end
	
	if kb.isDown("up") then
		player:jump()
	end
end
