extends Seed


func on_harvest_sprout():
	harvest(0,0,1,[seedPacket]) 

func on_harvest_flower():
	harvest(2,0,1,[seedPacket]) 

func on_harvest_fruit():
	harvest(4,0,1,[seedPacket]) 

func on_harvest_death():
	harvest(0,0,3,[seedPacket]) 
