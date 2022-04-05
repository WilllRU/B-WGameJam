extends Bullet

var bullet_type: int = 3
var proj : int = 3
var spread = proj * 10

func _init():
	fire_rate = 0.4

## Called when the node enters the scene tree for the first time.
func _ready():
	var ab : float = spread/(proj - 1)
	# The +1 is there to keep the middle bullet going straight
	var angle : float = -(spread/2) + 1
	for n in proj:
		var bullet = preload("res://BulletTypes/SpreadBullet.tscn")
		var l_b = bullet.instance()
		var dir = Vector2(cos(angle * PI / 180), sin(angle *PI / 180)).normalized()
		l_b.global_position = self.global_position + dir
		l_b.vec_dir = dir
		get_parent().call_deferred("add_child",l_b)
		
		angle += ab
	yield(get_tree().create_timer(.3, false),"timeout")
	queue_free()
	pass # Replace with function body.
