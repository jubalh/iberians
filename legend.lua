-- vim: noexpandtab:ts=4:sts=4:sw=4

legend = {}

function legend.draw()
	local txt_heading = "Legend"
	local y = 100

	love.graphics.setBackgroundColor(135, 31, 42)
	love.graphics.setColor(255, 214, 0)
	love.graphics.setFont(heading_font)
	love.graphics.print(txt_heading, (love.graphics.getWidth() - heading_font:getWidth(txt_heading)) / 2, y)
	love.graphics.setFont(std_font)

	love.graphics.setColor(255, 255, 255)

	local icon_x = 300
	local icon_y = 250
	for k, v in ipairs(resource_list) do
		love.graphics.draw(icon_img[v], icon_x, icon_y)
		love.graphics.print(v, icon_x + 300, icon_y)

		icon_y = icon_y + icon_img[v]:getHeight() + 50
	end
end
