extends Bullet

func _init():
	dmg = 2
	fire_rate = 0.2
	speed = .5
	vec_dir = Vector2(-1,0)
	pass

func _on_bullet_body_entered(_body) -> void:
	var player := _body as Ship
	if player:
		print("OH SHI--")
		player.dead = true
	create_explosion()
	pass # Replace with function body.


func _on_bullet_area_entered(_area):
	var player := _area as Ship
	if player:
		print("OH SHI--")
		player.dead = true
	create_explosion()
	pass # Replace with function body.
