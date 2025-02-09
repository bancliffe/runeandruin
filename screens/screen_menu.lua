options={"new game","quit"}
selected_menu_item=1

particles={}
max_particles=512
rune_marks={}
max_rune_marks=25

function init_menu()
	particles={}
	rune_marks={}
	for i=1,max_particles do
		add_menu_particle()
	end
	for i=1,max_rune_marks do
		add_rune_mark(true)
	end
	music(0)
end

function update_menu()
	if btnp(⬆️) then selected_menu_item-=1 sfx(10) end
	if btnp(⬇️) then selected_menu_item+=1 sfx(10) end
	if selected_menu_item > #options then
		selected_menu_item=1
	elseif selected_menu_item<1 then
		selected_menu_item=#options
	end	
	if btnp(❎) or btnp(🅾️) then
		if selected_menu_item==1 then
			music(-1)
			init_game()
			_update60=update_game
			_draw=draw_game
		elseif selected_menu_item==2 then
			-- goto unit creator screen
		elseif selected_menu_item==3 then
			extcmd("shutdown")
		end
	end
	update_menu_particles()
	update_rune_marks()
end

function draw_menu()
	cls(0)
	draw_menu_particles()
	draw_rune_marks()
	for y=1,#options do
			col=7
			if(y==selected_menu_item)col=8
			printc("\#0"..options[y],64,86+(y*8),col)
	end
	sspr(56,0,32,24,16,16,96,72)
	print("\#0SQUIZM",102,120,7)
end

function update_menu_particles()
	for p in all(particles) do
		p.y-=p.dy
		p.act-=1
		p.x+=sin(p.ang)*0.5
  p.ang+=0.01
		if p.act<0 then
			del(particles,p)
			add_menu_particle()
		end
		if p.act<50 then p.clr=9 end
		if p.act<10 then p.clr=2 end
	end
end

function draw_menu_particles()
	for p in all(particles) do
		circfill(p.x, p.y,p.rad,p.clr)
	end
end

function add_menu_particle()
	add(particles,{
			x=rnd(128),
			y=128,
			dx=rnd(2)+1,
			dy=rnd(2)-1,
			rad=rnd(2),
			act=30+rnd(60),
			clr=10,
			ang=rnd(1)
		})
end

function add_rune_mark(is_start)
	if is_start then
		add(rune_marks,{
				x=rnd(128),
				y=rnd(32),
				color=rnd({1,12}),
				angle=rnd(0.125)
			})
	else
		add(rune_marks,{
			x=0,
			y=rnd(32),
			color=rnd({1,12}),
			angle=rnd(0.125)
		})
	end
end

function update_rune_marks()
	for r in all(rune_marks) do
		r.x+=rnd(0.25)+0.1
		r.x+=sin(r.angle)*rnd(0.25)
  	r.y+=sin(r.angle)*rnd(0.25)
		r.angle+=0.01

		if r.x < 0 or r.x > 128 then
			del(rune_marks,r)
			add_rune_mark(false)
		end
	end
end

function draw_rune_marks()
	for r in all(rune_marks) do
		circfill(r.x, r.y,1,r.color)
	end
end