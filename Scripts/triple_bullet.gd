extends "bullet.gd"

var bullet_type: int = 3
var dir : int = 3
var spread = dir * 10

func _init():
	fire_rate = 0.3

## Called when the node enters the scene tree for the first time.
func _ready():
	var ab : float = spread/(dir -1)
	var angle : float = -ab
	for n in dir:
		var bullet = preload("res://BulletTypes/SpreadBullet.tscn")
		var l_b = bullet.instance()
		var a : float = float(angle/(spread*2))
		var dir = Vector2(1, a).normalized()
		l_b.global_position = self.global_position + dir
		l_b.vec_dir = dir
		get_parent().call_deferred("add_child",l_b)
		#yield(get_tree().create_timer(.1, false),"timeout")
		angle += ab
	queue_free()
	pass # Replace with function body.
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
