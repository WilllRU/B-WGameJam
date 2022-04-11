extends Bullet

func _init():
	dmg = 1
	speed = .5
	vec_dir = Vector2(-1,0)
	pass

func _on_bullet_body_entered(_body) -> void:
	var player := _body as Ship
	if player:
		#enemy.dead = true
		print("Faster Bullet")
		player.f_r -= 0.05
		queue_free()
	
	pass # Replace with function body.

func _on_bullet_area_entered(_area) -> void:
	var player := _area as Ship
	if player:
		#enemy.dead = true
		print("Faster Bullet")
		player.f_r -= 0.05
		queue_free()
	
	pass
