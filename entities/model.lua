model=class:new({
  name="undefined", 
  speed=1,
  defense="d6",
  firepower="d6",
  prowess="d6",
  willpower="d6",
  state={},
  actions={},
  weapon_ranged=0,
  weapon_close_combat=0,
  equipment={},
  tile_x=0,
  tile_y=0,
  sprite=64,
  })

  STATES={}
  STATES.DOWN=0
  STATES.STAGGERED=1
  STATES.OUT_OF_ACTION=13
  STATES.AIM_1=2
  STATES.AIM_2=3
  STATES.MOVE_1=4
  STATES.MOVE_2=5
  STATES.MOVE_3=6
  STATES.SHOOT_1=7
  STATES.SHOOT_2=8
  STATES.SHOOT_3=9
  STATES.FIGHT_1=10
  STATES.FIGHT_2=11
  STATES.FIGHT_3=12

  function generate_name()
    local consonants={"b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","w","z"}
    local final_cons={"c","d","f","g","h","k","l","m","n","p","r","s","t"}
    local vowels={"a","ae","au","ai","e","i","o","u","ou"}
    local complex={"th","st","pr","st","sr","th","tr"}
    local nm

    if rnd(100)>75 then
      nm = rnd(complex)..rnd(vowels)..rnd(consonants)
    else
      nm = rnd(consonants)..rnd(vowels)..rnd(consonants)
    end     
    -- Chance at fancier name
    if rnd(100)>75 then
      nm=nm..rnd(vowels)
      if rnd(100)>50 then
        nm=nm..rnd(final_cons)
      end
    end
    return nm
  end