intro = {}

local sun_img
local heading_font

function intro.load()
	sun_img = love.graphics.newImage("assets/images/sun.png")
	heading_font = love.graphics.newFont(64)
	std_font = love.graphics.newFont()
end

function intro.draw()
	local heading = "Iberians"
	love.graphics.setBackgroundColor(135, 31, 42)
	love.graphics.draw(sun_img, (love.graphics.getWidth() - sun_img:getWidth())/2, 30)
	love.graphics.setColor(255, 214, 0)
	love.graphics.setFont(heading_font)
	love.graphics.print(heading, (love.graphics.getWidth() - heading_font:getWidth(heading)) / 2, 30 + sun_img:getHeight() + 30)
	love.graphics.setFont(std_font)
	love.graphics.setColor(255, 255, 255)
end
