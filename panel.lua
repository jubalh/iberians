require("board")

panel = {}
icon_img = {}
local action_menu_btn = {}
local action_btns = {"build", "trade", "develcards"}

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
	local icon_x = x + 10
	local icon_y = y - 10
	local text_y = icon_y + 20
	-- space after an icon (before text)
	local icon_distance = 10
	-- space after text
	local text_distance = 20

	-- calculate the positions of the action buttons (trade, build, develcards)
	for k, v in ipairs(action_btns) do
		action_menu_btn[v] = {}
		action_menu_btn[v].x = icon_x
		action_menu_btn[v].y = icon_y
		action_menu_btn[v].w = action_icon_img:getWidth()
		action_menu_btn[v].h = action_icon_img:getHeight()
		icon_x = icon_x + action_menu_btn[v].w + icon_distance
	end

	-- draw action buttons
	love.graphics.setColor(0, 0, 0)
	love.graphics.draw(action_icon_img, action_menu_btn["build"].x, action_menu_btn["build"].y)
	love.graphics.setColor(255, 0, 0)
	love.graphics.draw(action_icon_img, action_menu_btn["trade"].x, action_menu_btn["trade"].y)
	love.graphics.setColor(0, 255, 0)
	love.graphics.draw(action_icon_img, action_menu_btn["develcards"].x, action_menu_btn["develcards"].y)
	love.graphics.setColor(255, 255, 255)

	-- some distance between action buttons and resource icons
	icon_x = icon_x + 20

	-- going through resource list
	for k, v in ipairs(resource_list) do
		-- draw icon and calculate new x
		love.graphics.draw(icon_img[v], icon_x, icon_y)
		icon_x = icon_x + icon_img[v]:getWidth() + icon_distance
		-- draw text (nr of resources) and calculate new x
		love.graphics.print(player[1].resource[v], icon_x, text_y)
		icon_x = icon_x + love.graphics.newFont():getWidth(player[1].resource[v]) + text_distance
	end
end

function panel.mousepressed(x, y, button)
	if x >= action_menu_btn["build"].x and x <= (action_menu_btn["build"].x + action_menu_btn["build"].w)
		and y >= action_menu_btn["build"].y and y <= (action_menu_btn["build"].y + action_menu_btn["build"].h) then
			print("build action menu button pressed")
			-- treat this as 'build street' button for now
		    game.action = "street"
	end
end
