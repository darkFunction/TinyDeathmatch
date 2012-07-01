require("AnAL")

Assets = {}
Assets.animations = {}

function Assets:load()
	self.imagePlayerJump = love.graphics.newImage("assets/weeguyjump.png")
	self.imagePlayerFall = love.graphics.newImage("assets/weeguyfall.png")
	self.imagePlayerRun = love.graphics.newImage("assets/weeguyrun.png")

	self.bgData = love.image.newImageData("assets/bg.png")
	self.bg = love.graphics.newImage(self.bgData)
end

function Assets:addAnimation(item, type)
	local anim = nil
	if type == "run" then
		anim = newAnimation(self.imagePlayerRun, 48, 48, 0.04, 0) 
	end
	if not self.animations[item] then self.animations[item] = {} end
	self.animations[item][type] = anim
	return anim
end

function Assets:removeAnimation(item)
	self.animations[item] = nil
end
