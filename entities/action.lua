action=class:new({name="undefined", on_action=0})

action_move=action:new({
	name="move",
	on_action=function(dest_tile)
		-- move to that place
	end
})

action_aim=action:new({
	name="aim",
	on_action=function(shooter)
		-- increase next shoot DT
	end
})

action_shoot=action:new({
	name="shoot",
	on_action=function(shooter, target)
		-- shoot at target
	end
})

action_fight=action:new({
	name="fight",
	on_action=function(fighter, target)
		-- fight in close combat
	end
})

action_disengage=action:new({
	name="disengage",
	on_action=function(dest_tile)
		-- move out of close combat
	end
})

action_psychic_power=action:new({
	name="psychic power",
	on_action=function(caster, target)
		-- tbd
	end
})

action_recover=action:new({
	name="recover",
	on_action=function()
		-- make willpower roll to remove STAGGERED state
	end
})

action_stand=action:new({
	name="stand",
	on_action=function()
		-- remove DOWN state
	end
})

action_use_item=action:new({
	name="use item",
	on_action=function(item)
		-- use item
	end
})