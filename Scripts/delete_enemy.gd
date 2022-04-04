extends Area2D


func _on_Area2D_area_entered(area):
	var enemy := area as Enemy
	if enemy:
		print("Snapped")
		enemy.queue_free()
	pass # Replace with function body.
