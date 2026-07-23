extends Seed


func on_harvest_sprout():
	harvest(0,1,0,[seedPacket]) 
	
func on_harvest_flower():
	harvest(0,2,0,[seedPacket]) 

func on_harvest_fruit():
	harvest(0,4,0,[seedPacket]) 
