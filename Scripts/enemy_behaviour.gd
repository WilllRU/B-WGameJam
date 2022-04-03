extends "enemy.gd"

func _init():
	health = 6

func _on_Enemy_body_entered(body):
	var player := body as ShipMovement
	if player:
		player.dead = true
		print("OH NOOOOOOOO!!!")
	pass # Replace with function body.
