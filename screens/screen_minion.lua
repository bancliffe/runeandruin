minion_options={"create","edit","delete"}
selected_minion=1

function init_minion()
	music(2)
end

function update_minion()
	if btnp(⬅️) then selected_minion -=1 sfx(10) end
	if btnp(➡️) then selected_minion +=1 sfx(10) end
	selected_minion=mid(1,selected_minion,#minions)
	if btnp(🅾️) then
		init_menu()
		_update60=update_menu
		_draw=draw_menu
	end
end

function calc_cost(unit)
	-- TBD
end