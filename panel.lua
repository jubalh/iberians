require("board")

panel = {}
icon_img = {}
local action_menu_btn = {}

function panel.load()
	-- resource icons
	for _, v in ipairs(resource_list) do
		icon_img[v] = love.graphics.newImage("assets/images/icons/"..v..".png")
	end
	-- action icons
	action_icon_img = love.graphics.newImage("assets/images/action-icon.png")
end

function panel.drawBar()
	-- background bar
	local x = 100
	local y = love.graphics.getHeight() - 40
	local width = love.graphics.getWidth() - 200
	local height = 35

	--love.graphics.setColor(82, 50, 23)
	love.graphics.setColor(117, 32, 4)
	love.graphics.rectangle("fill", x, y, width, height)
	love.graphics.setColor(255,255,255)

	-- where to draw the icon
	local icon_x = x + 100
	local icon_y = y - 10
	local text_y = icon_y + 20
	-- space after an icon (before text)
	local icon_distance = 10
	-- space after text
	local text_distance = 50

	-- going through resource list
	for k, v in ipairs(resource_list) do
		-- draw icon and calculate new x
		love.graphics.draw(icon_img[v], icon_x, icon_y)
		icon_x = icon_x + icon_img[v]:getWidth() + icon_distance
		-- draw text (nr of resources) and calculate new x
		love.graphics.print(player[1].resource[v], icon_x, text_y)
		icon_x = icon_x + love.graphics.newFont():getWidth(player[1].resource[v]) + text_distance
	end

	x = 110
	y = love.graphics.getHeight() - 50
	action_menu_btn["action"] = {}
	action_menu_btn["action"].x = x
	action_menu_btn["action"].y = y
	action_menu_btn["action"].w = 50
	action_menu_btn["action"].h = 50
	love.graphics.draw(action_icon_img, x, y)
end

function panel.mousepressed(x, y, button)
	if x >= action_menu_btn["action"].x and x <= (action_menu_btn["action"].x + action_menu_btn["action"].w)
		and y >= action_menu_btn["action"].y and y <= (action_menu_btn["action"].y + action_menu_btn["action"].h) then
			print("action menu button pressed")
	end
end
