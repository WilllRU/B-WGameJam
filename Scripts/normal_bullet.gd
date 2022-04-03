extends "bullet.gd"


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

## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#func _physics_process(_delta):
#	count += 1
#	position.x += speed
#	if count > life_time:
#		create_explosion()
#
#func _on_bullet_body_entered(_body):
#	create_explosion()
#	pass # Replace with function body.
#
#func _on_bullet_area_entered(_area):
#	create_explosion()
#	pass # Replace with function body.
#
#func create_explosion() -> void:
#
#	var e = explosion.instance()
#	e.global_position = self.global_position
#	get_parent().call_deferred("add_child",e)
#	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
