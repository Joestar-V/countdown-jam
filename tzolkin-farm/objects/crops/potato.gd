extends Seed

func on_harvest_sprout():
	harvest(2,0,0,[]) 


func on_harvest_flower():
	harvest(3,0,0,[]) 

func on_harvest_fruit():
	harvest(4,0,0,[seedPacket,seedPacket]) 
