extends Area2D


func _on_Area2D_area_entered(area):
	var obj := area as Area2D
	if obj:
		print("Snapped")
		obj.queue_free()
	pass # Replace with function body.
