extends Label

var coins = 0

func _ready():
	text = String(coins)



func _on_coin_coinCollected():
	coins += 1
	_ready()
