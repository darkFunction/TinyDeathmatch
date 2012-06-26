require("AnAL")

Assets = {}
Assets.animPlayerRun = nil

function Assets:load()
	local img = love.graphics.newImage("assets/weeguyrun.png")
	Assets.animPlayerRun = newAnimation(img, 48, 48, 0.05, 0)
end
