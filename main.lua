debug = true

local myscale = 0.4

function love.load()
	img = {}
	-- resources
	img["brick"] = love.graphics.newImage("assets/images/brick.png")
	img["iron"] = love.graphics.newImage("assets/images/iron.png")
	img["wheat"] = love.graphics.newImage("assets/images/wheat.png")
	img["wood"] = love.graphics.newImage("assets/images/wood.png")
	img["wool"] = love.graphics.newImage("assets/images/wool.png")
	-- empty
	img["desert"] = love.graphics.newImage("assets/images/desert.png")
	img["water"] = love.graphics.newImage("assets/images/water.png")

	tile_width = img["brick"]:getWidth()
	tile_height = img["brick"]:getHeight()

	-- recalculate height according to scale
	-- testing
	tile_height = math.floor(tile_height * myscale)
	tile_width = math.floor(tile_width * myscale)

	board = createBoard()
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

function setTileByNr(cell, nr)
	if nr == 1 then
		cell.tile = "brick"
	elseif nr == 2 then
		cell.tile = "iron"
	elseif nr == 3 then
		cell.tile = "wheat"
	elseif nr == 4 then
		cell.tile = "wood"
	elseif nr == 5 then
		cell.tile = "wool"
	elseif nr == 6 then
		cell.tile = "desert"
	end
end

function createBoard()
	-- create 2d board array
	local board = {}
	for x = 1, 5 do
		board[x] = {}
		for y = 1, 5 do
			board[x][y] = {}
		end
	end

	-- generate a list with random numbers from one to 5 standing for each tile variant
	local r = {}
	for i = 1, 19 do
		r[i] = love.math.random(1, 5)
	end

	-- desert
	local desertpos = love.math.random(1,19)
	r[desertpos] = 6

	local i = 1

	-- init game board
	for x = 2, 4 do
		setTileByNr(board[x][1], r[i])
		i = i + 1
		setTileByNr(board[x][5], r[i])
		i = i + 1
	end
	for x = 1, 4 do
		setTileByNr(board[x][2], r[i])
		i = i + 1
		setTileByNr(board[x][4], r[i])
		i = i + 1
	end
	for x = 1, 5 do
		setTileByNr(board[x][3], r[i])
		i = i + 1
	end

	return board
end
