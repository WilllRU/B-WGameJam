extends Bullet

func _init():
	dmg = 1
	speed = 2
	pass
	
func bullet_movement() -> void:
	position += vec_dir.normalized() * speed

func _on_bullet_body_entered(_body) -> void:
	var enemy := _body as Enemy
	var aster := _body as Asteroid
	if enemy:
		#enemy.dead = true
		print("HIT")
		enemy.take_damage(dmg)
	if aster: 
		print("Space Rock")
		aster.take_damage(dmg)
	create_explosion()
	pass # Replace with function body.

func _on_bullet_area_entered(_area) -> void:
	var enemy := _area as Enemy
	var aster := _area as Asteroid
	if enemy:
		enemy.take_damage(dmg)
	if aster: 
		print("Space Rock")
		aster.take_damage(dmg)
	create_explosion()
	pass
