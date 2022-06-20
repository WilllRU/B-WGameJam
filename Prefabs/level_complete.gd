extends Area2D

func _physics_process(delta):
	position.x -= 30* delta

func _on_Node2D_area_entered(area):
	var player := area as Ship
	if player:
		print("YAY")
		player.level_complete()
		queue_free()
	pass # Replace with function body.


func _on_Node2D_body_entered(body):
	var player := body as Ship
	if player:
		print("YAY")
		player.level_complete()
		queue_free()
