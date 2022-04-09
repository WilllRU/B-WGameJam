class_name Asteroid
extends Hazard
var split : int = 2
var rot : Array = [-90,0,90,180]
var dir : Array = [170,180,-170]
var data : Array = [Rect2(36,20,8,8),Rect2(32,0,16,16),Rect2(0,0,32,32)]

func _init():
	accel = 1
	c_dir = Vector2(-1.0,0.0)
func _ready():
	health = 2 * (split + 1)
	$Sprite.region_rect = data[split]
	var circ = CircleShape2D.new()
	circ.radius = floor(16 / (3 - split))

	$CollisionShape2D.shape = circ
	rotation_degrees = rot[randi() % rot.size()]
	

func take_damage(hp : int) -> void:
	health -= hp
	if health <= 0:
		explode()
	pass

func _physics_process(_delta):
	# Writing it like this makes it work for some reason???
	var move = c_dir * accel/(split + 1)
	position += move

func explode() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	for n in 2:
		var e = Master.explosion.instance()
		e.global_position = self.global_position
		e.scale += Vector2(n, n) * (split + 1)
		get_parent().call_deferred("add_child",e)
		$Timer.start(0.2);yield($Timer,"timeout")
	if split > 0:
		split -= 1
		for n in 2:
			var a = Master.asteroid.instance()
			a.global_position = self.global_position + Vector2(0,(-4*(split+1) + (n*(8*(1+split)))))
			a.c_dir = Vector2(cos(dir[randi() % dir.size()] * PI / 180), sin(dir[randi() % dir.size()] *PI / 180)).normalized()
			a.split = split
			get_parent().call_deferred("add_child",a)
			pass
		pass
	queue_free()


func _on_Enemy_body_entered(body):
	var player := body as Ship
	if player:
		player.dead = true
		print("OH NOOOOOOOO!!!")
	pass # Replace with function body.
