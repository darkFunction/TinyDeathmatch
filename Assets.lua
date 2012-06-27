require("AnAL")

Assets = {}
Assets.animPlayerRun = nil
Assets.imagePlayerJump = nil

function Assets:load()
	local img = love.graphics.newImage("assets/weeguyrun.png")
	self.animPlayerRun = newAnimation(img, 48, 48, 0.04, 0)

	self.imagePlayerJump = love.graphics.newImage("assets/weeguyjump.png")
end
