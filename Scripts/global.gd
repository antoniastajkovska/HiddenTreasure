extends Node

var coins := 0
var chest := 0
const NUM_COINS_TO_WIN = 30
const NUM_CHEST_TO_WIN = 1

func collected_all() -> bool:
	if coins >= NUM_COINS_TO_WIN && chest >= NUM_CHEST_TO_WIN:
		return true
	return false 
