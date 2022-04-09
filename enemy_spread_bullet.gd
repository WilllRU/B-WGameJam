extends Bullet

var bullet_type: int = 3
var proj : int = 2
var spread = proj * 10


## Called when the node enters the scene tree for the first time.
func _ready():
	var ab : float = 0
	var angle : float = 0
	if proj > 1:
		ab = spread/(proj - 1)
		# The +1 is there to keep the middle bullet going straight
		angle = -(spread/2) + 1

	for n in proj:
		var l_b = Master.spread[1].instance()
		var dir = Vector2(cos((angle+180) * PI / 180), sin((angle+180) *PI / 180)).normalized()
		l_b.global_position = self.global_position + dir
		l_b.vec_dir = dir
		get_parent().call_deferred("add_child",l_b)
		
		angle += ab
	$Timer.start(.3);yield($Timer,"timeout")
	queue_free()
	pass # Replace with function body.
