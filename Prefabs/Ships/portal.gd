extends Area2D


func _ready():
	var r = 256/144
	var pos : Vector2 = global_position
	pos.x = pos.x / 256;
	pos.x = (pos.x - 0.5) / r + 0.5;
	pos.y = (144 - pos.y) / 144;
	$CanvasLayer/ColorRect.material.set_shader_param("center", pos)
#	$Timer.start(2.0); yield($Timer, "timeout")
#	var s = obj.instance()
#	s.global_position = self.global_position
#	get_parent().call_deferred("add_child",s)
#	$Timer.start(1.0); yield($Timer, "timeout")
#	queue_free()

func _on_Area2D_area_entered(area):
	var player := area as Ship
	if player:
		print("HIT")
		player.queue_free()
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	var player := body as Ship
	if player:
		print("HIT")
		player.queue_free()
	pass # Replace with function body.
