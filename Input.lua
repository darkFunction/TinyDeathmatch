Input = {}
function Input:update(world)

	playerInput(world.player1, "left", "right", "up")
	playerInput(world.player2, "a", "d", "w")

end

function playerInput(player, left, right, up)

	local kb = love.keyboard

	if kb.isDown(right) then
		player:moveRight()	
	elseif kb.isDown(left) then
		player:moveLeft()	
	else
		player.velocity.x = 0;
	end
	
	if kb.isDown(up) then
		player:jump()
	end

end
