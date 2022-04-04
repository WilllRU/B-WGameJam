extends Bullet


func _init():
	dmg = 2
	fire_rate = 0.2
	speed = 2
	pass

func _on_bullet_body_entered(_body) -> void:
	var enemy := _body as Enemy
	if enemy:
		#enemy.dead = true
		print("HIT")
		enemy.take_damage(dmg)
	create_explosion()
	pass # Replace with function body.

func _on_bullet_area_entered(_area) -> void:
	var enemy := _area as Enemy
	if enemy:
		#enemy.dead = true
		print("HIT")
		enemy.take_damage(dmg)
	create_explosion()
	pass # Replace with function body.
