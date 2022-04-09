extends Bullet


func _init():
	dmg = 2
	fire_rate = 0.3
	speed = 3
	pass

func _on_bullet_body_entered(_body) -> void:
	var haz := _body as Hazard
	if haz:
		print("HIT")
		haz.take_damage(dmg)
	create_explosion()
	pass # Replace with function body.

func _on_bullet_area_entered(_area) -> void:
	var haz := _area as Hazard
	if haz:
		haz.take_damage(dmg)
	create_explosion()
	pass # Replace with function body.
