Actor = { 
	type="Actor"
}

function Actor:new()
	local newinst = {
		position = {x=0, y =0},
		velocity = {x=0, y=0},
		facing = "left",
		state = 0,
		onPlatform = nil
	}
    setmetatable( newinst, { __index = self } )
    return newinst
end

