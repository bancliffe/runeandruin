-- ❎🅾️⬆️⬇️⬅️➡️

function update_action_view()
  curs:update()
	game_cam:update()
	if (btnp(➡️,0)) gm.active_unit+=1 selected_action=1
	if (btnp(⬅️,0)) gm.active_unit-=1 selected_action=1
	if (btnp(⬇️,0)) selected_action+=1
	if (btnp(⬆️,0)) selected_action-=1
  if (btnp(❎,0)) then
    if gm.units[gm.active_unit].actions[selected_action].name=="move" then
      log("Moving unit!")
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

function update_choose_action()
end

function update_action_move()
  
end

function update_action_pass()
end