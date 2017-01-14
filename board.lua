board = {}
board.grid = {}

local tile_img = {}
icon_img = {}

line_store = {}
mouse = {}
mouse.x = 0
mouse.y = 0

local function setTileByNr(cell, nr)
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

function board.createBoard()
	-- create 2d board array
	local grid = {}
	for x = 1, 5 do
		grid[x] = {}
		for y = 1, 5 do
			grid[x][y] = {}
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

	-- init game grid
	for x = 2, 4 do
		setTileByNr(grid[x][1], r[i])
		i = i + 1
		setTileByNr(grid[x][5], r[i])
		i = i + 1
	end
	for x = 1, 4 do
		setTileByNr(grid[x][2], r[i])
		i = i + 1
		setTileByNr(grid[x][4], r[i])
		i = i + 1
	end
	for x = 1, 5 do
		setTileByNr(grid[x][3], r[i])
		i = i + 1
	end

	return grid
end

function board.load()
	-- resources
	for _, v in ipairs(resource_list) do
		tile_img[v] = love.graphics.newImage("assets/images/tiles/"..v..".png")
		icon_img[v] = love.graphics.newImage("assets/images/icons/"..v..".png")
	end
	-- other tiles
	tile_img["desert"] = love.graphics.newImage("assets/images/tiles/desert.png")
	tile_img["water"] = love.graphics.newImage("assets/images/tiles/water.png")

	-- all tiles have the same size
	tile_width = tile_img["brick"]:getWidth()
	tile_height = tile_img["brick"]:getHeight()

	res_val_font = love.graphics.newFont(14)
end

function board.draw(x, y)
	if x == nil then x = 0 end
	if y == nil then y = 0 end

	local res_i = 1
	for xi = 1, #board.grid do
		for yi = 1, #board.grid[xi] do
			if board.grid[xi][yi].tile ~= nil then
				local xpos = (xi-1) * tile_width
				local ypos = (yi-1) * tile_height

				if(yi % 2 == 0) then
					xpos = xpos + tile_width/2
				end
				if yi > 1 then
					ypos = ypos - (tile_height/4*(yi-1))
				end

				xpos = xpos + x
				ypos = ypos + y

				-- draw tile
				love.graphics.draw(tile_img[board.grid[xi][yi].tile], xpos, ypos)
				-- remember position
				board.grid[xi][yi].x = xpos
				board.grid[xi][yi].y = ypos

				-- draw value for tile
				if show_res_val and board.grid[xi][yi].tile ~= "desert" then
					local radius = 15
					love.graphics.setFont(res_val_font)
					love.graphics.setColor(52,52,52)
					love.graphics.circle("fill", xpos + tile_width/2, ypos + tile_height - 30 - radius/2, radius)
					love.graphics.setColor(255,255,255)
					love.graphics.print(resource_value_pool[res_i], xpos + tile_width/2 - res_val_font:getWidth("8")/2, ypos + tile_height - 30 - 15)
					res_i = res_i + 1
					love.graphics.setColor(255,255,255)
				end
			end
		end
	end

	if debug then
		love.graphics.setColor(255,0,0)
		love.graphics.print(mouse.x..", "..mouse.y, 10, 10)
		-- show in which direction of a tile the cursor is
		-- in this direction we will then want to build a street(etc)
		for i, l  in ipairs(line_store) do
			love.graphics.line(l.x, l.y, l.x2, l.y2)
		end
		love.graphics.setColor(255,255,255)
	end

	if debug then
		love.graphics.setColor(255,0,0)
		-- height is -1 because we 4 times subtract a quarter (see above
		love.graphics.rectangle("line", x, y, tile_width * #board.grid[3], tile_height * (#board.grid - 1))
		love.graphics.setColor(255,255,255)
	end
end

function board.drawBar()
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
		love.graphics.draw(icon_img[v], icon_x, icon_y) icon_x = icon_x + icon_img[v]:getWidth() + icon_distance
		-- draw text (nr of resources) and calculate new x
		love.graphics.print(player[1].resource[v], icon_x, text_y)
		icon_x = icon_x + love.graphics.newFont():getWidth(player[1].resource[v]) + text_distance
	end
end

function board.mousemoved(x, y, dx, dy)
	mouse.x = x
	mouse.y = y
	-- find out on which tile the mouse is
	for xi = 1, #board.grid do
		for yi = 1, #board.grid[xi] do
			-- if not empty
			if board.grid[xi][yi].tile ~= nil then

				if x >= board.grid[xi][yi].x and x < (board.grid[xi][yi].x + tile_width)
					and y >= board.grid[xi][yi].y and y < (board.grid[xi][yi].y + tile_height) then

					local l = {}

					-- upper quarter (tip) of tile
					if y < board.grid[xi][yi].y + tile_height/4 then
						-- tip point is common
						l.x = board.grid[xi][yi].x + tile_width/2
						l.y = board.grid[xi][yi].y

						-- left side of tip
						if x < board.grid[xi][yi].x + tile_width/2 then
							--print("left side tip")
							l.x2 = board.grid[xi][yi].x
							l.y2 = board.grid[xi][yi].y + tile_height/4
						-- right side
						else
							--print("right side tip")
							l.x2 = board.grid[xi][yi].x + tile_width
							l.y2 = board.grid[xi][yi].y + tile_height/4
						end
					-- lower quarter
					elseif y > board.grid[xi][yi].y + tile_height*3/4 then

						-- lowest point is common
						l.x = board.grid[xi][yi].x + tile_width/2
						l.y = board.grid[xi][yi].y + tile_height

						if x < board.grid[xi][yi].x + tile_width/2 then
							--print("left side lower")
							l.x2 = board.grid[xi][yi].x
							l.y2 = board.grid[xi][yi].y + tile_height*3/4
						-- right side
						else
							--print("right side lower")
							l.x2 = board.grid[xi][yi].x + tile_width
							l.y2 = board.grid[xi][yi].y + tile_height*3/4
						end
				    -- middle
					else
						-- left side of tile
						if  x < board.grid[xi][yi].x + tile_width/2 then
							--print("left side tile")
							l.y = board.grid[xi][yi].y + tile_height/4
							l.x = board.grid[xi][yi].x
							l.y2 = l.y + tile_height/2
							l.x2 = l.x
						-- right side of tile
						else
							--print("right side tile")
							l.y = board.grid[xi][yi].y + tile_height/4
							l.x = board.grid[xi][yi].x + tile_width
							l.y2 = l.y + tile_height/2
							l.x2 = l.x
						end
					end

					table.remove(line_store, 1)
					table.insert(line_store, l)
				end
			end
		end
	end
end
