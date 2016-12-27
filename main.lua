debug = true

local myscale = 0.5

function love.load()
	img = {}
	img["brick"] = love.graphics.newImage("assets/images/brick.png")
	img["desert"] = love.graphics.newImage("assets/images/desert.png")
	img["iron"] = love.graphics.newImage("assets/images/iron.png")
	img["water"] = love.graphics.newImage("assets/images/water.png")
	img["wheat"] = love.graphics.newImage("assets/images/wheat.png")
	img["wood"] = love.graphics.newImage("assets/images/wood.png")
	img["wool"] = love.graphics.newImage("assets/images/wool.png")

	tile_width = img["brick"]:getWidth()
	tile_height = img["brick"]:getHeight()

	-- create 2d board array
	board = {}
	for x = 1, 5 do
		board[x] = {}
		for y = 1, 5 do
			board[x][y] = {}
		end
	end

	-- init game board
	for x = 2, 4 do
		board[x][1].tile = "brick"
		board[x][5].tile = "brick"
	end
	for x = 1, 4 do
		board[x][2].tile = "wood"
		board[x][4].tile = "wood"
	end
	for x = 1, 5 do
		board[x][3].tile = "iron"
	end

	tile_height = math.floor(tile_height * myscale)
	tile_width = math.floor(tile_width * myscale)
end

function love.update(dt)
end

function love.draw()
	for x = 1, #board do
		for y = 1, #board[x] do
			if board[x][y].tile ~= nil then
				local xpos = (x-1) * tile_width
				local ypos = (y-1) * tile_height

				if(y % 2 == 0) then
					xpos = xpos + tile_width/2
				end
				if y > 1 then
					ypos = ypos - (tile_height/4*(y-1))
				end

				love.graphics.draw(img[board[x][y].tile], xpos, ypos, 0, myscale, myscale)
			end
		end
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end
