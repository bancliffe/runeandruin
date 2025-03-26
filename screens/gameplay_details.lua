-- ❎🅾️⬆️⬇️⬅️➡️

--[[
	View the battlefield and cycle through units
]]
function update_action_view()
  curs:update()
	game_cam:update()
	if (btnp(➡️,0)) gm.active_unit+=1 selected_action=1
	if (btnp(⬅️,0)) gm.active_unit-=1 selected_action=1
	if (btnp(⬇️,0)) selected_action+=1
	if (btnp(⬆️,0)) selected_action-=1
  if (btnp(❎,0)) then
		action_name = gm.units[gm.active_unit].actions[selected_action].name
    if action_name=="move" then
      _update60=update_action_move
			_draw=draw_action_move
		elseif action_name=="shoot" then
			_update60=update_action_shoot
			_draw=draw_action_shoot
			game_cam.target=curs
		elseif action_name=="fight" then
			_update60=update_action_fight
			_draw=draw_action_fight
		elseif action_name=="pass" then
			gm.active_unit+=1 
			selected_action=1
    end
  end
	gm.active_unit=mid(1,gm.active_unit,#gm.units)
	selected_action=mid(1,selected_action,#gm.units[gm.active_unit].actions)
	game_cam.target=gm.units[gm.active_unit]	
end

function draw_action_view()
  cls(0)
	game_cam:draw()
	map()
	circ(gm.units[gm.active_unit].tile_x*8 +4,gm.units[gm.active_unit].tile_y*8+4,4,8)
	draw_units()

	-- draw ui stuff
	camera()
	if btn(❎,1) then
		-- player 2 controls
		draw_unit_stats()
	end
	
	unit = gm.units[gm.active_unit]
	for i=1,#unit.actions do
		action = unit.actions[i]
		col = 7
		if (i==selected_action) col=10
		print("\#0"..action.name, 2, 2 + 7*(i-1), col)
	end
end

--[[
	Move the selected unit
]]
function update_action_move()
  if (btnp(🅾️,0)) then
		_update60=update_action_view
		_draw=draw_action_view
	end
end

function draw_action_move()
	cls(0)
	game_cam:draw()
	map()
	circ(gm.units[gm.active_unit].tile_x*8 +4,gm.units[gm.active_unit].tile_y*8+4,4,8)
	draw_units()

	-- draw ui stuff
	camera()
	unit = gm.units[gm.active_unit]
	print("\#0"..unit.name.." moving.", 2, 2, 8)
end

--[[
	Shoot with the active unit
]]
	function update_action_shoot()
		curs:update()
		game_cam:update()
		if (btnp(🅾️,0)) then
			_update60=update_action_view
			_draw=draw_action_view
		end
		if (btnp(➡️,0)) curs.x+=8
		if (btnp(⬅️,0)) curs.x-=8
		if (btnp(⬇️,0)) curs.y+=8
		if (btnp(⬆️,0)) curs.y-=8
  	--if (btnp(❎,0)) 
		--[[
		create target cursor
		mouse movement follows cursor now
		]]
	end

	function draw_action_shoot()
		cls(0)
		game_cam:draw()
		map()
		circ(gm.units[gm.active_unit].tile_x*8 +4,gm.units[gm.active_unit].tile_y*8+4,4,8)
		draw_units()
		curs:draw()

		-- draw ui stuff
		camera()
		unit = gm.units[gm.active_unit]
		print("\#0"..unit.name.." shooting.", 2, 2, 8)
	end

	--[[
	Shoot with the active unit
]]
function update_action_fight()
	if (btnp(🅾️,0)) then
		_update60=update_action_view
		_draw=draw_action_view
	end
end

function draw_action_fight()
	cls(0)
	game_cam:draw()
	map()
	circ(gm.units[gm.active_unit].tile_x*8 +4,gm.units[gm.active_unit].tile_y*8+4,4,8)
	draw_units()

	-- draw ui stuff
	camera()
	unit = gm.units[gm.active_unit]
	print("\#0"..unit.name.." fighting.", 2, 2, 8)
end