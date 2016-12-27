intro = {}
startmenu = {}

local sun_img
local heading_font

local items_list = { "new", "exit" }

function intro.load()
	sun_img = love.graphics.newImage("assets/images/sun.png")
    heading_font = love.graphics.newFont(64)
	std_font = love.graphics.newFont(24)
end

-- adds items to a menu structure
-- the values will be needed later when we want to
-- react to mouse clicks
function addMenu(menu, item, x, y, w, h)
	menu[item] = {}
	menu[item].x = x
	menu[item].y = y
	menu[item].w = w
	menu[item].w = h
	love.graphics.rectangle("line", x, y, w, h)

	return h
end

function intro.draw()
	local item_text = {}
	local txt_heading = "Iberians"
	local y = 100
	local menu_padding = 4
	local menu_space = 15

	love.graphics.setBackgroundColor(135, 31, 42)

	-- draw iberians heading
	love.graphics.setColor(255, 214, 0)
	love.graphics.setFont(heading_font)
	love.graphics.print(txt_heading, (love.graphics.getWidth() - heading_font:getWidth(txt_heading)) / 2, y)

	y = y + heading_font:getHeight()

	-- draw sun image
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(sun_img, (love.graphics.getWidth() - sun_img:getWidth())/2, y)
	love.graphics.setColor(255, 214, 0)

	y = y + sun_img:getHeight() + 30

	-- define the text for all menu items according to items_list
	item_text["new"] = "New Game"
	item_text["exit"] = "Exit"

	love.graphics.setFont(std_font)

	-- go through all items
	for _, v in ipairs(items_list) do
		love.graphics.print(item_text[v], (love.graphics.getWidth() - std_font:getWidth(item_text[v])) / 2, y)

		-- draw menu around it and add to the menu structure
		y = y + addMenu(startmenu, v, 
					(love.graphics.getWidth() - std_font:getWidth(item_text[v])) / 2 - menu_padding,
					y - menu_padding,
					std_font:getWidth(item_text[v]) + 2*menu_padding,
					std_font:getHeight() + 2*menu_padding)

		y = y + menu_space
	end

	love.graphics.setColor(255, 255, 255)
end
