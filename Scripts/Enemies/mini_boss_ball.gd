extends MiniBoss

signal BossAwake (health)
signal BossHealth (health)

var move_boss = [{
		0 : [Vector2(0,-1),2.0,false],
		1 : [Vector2(0,1),4.0,true],
		2 : [Vector2(0,-1),2.0,true],
		3 : [Vector2(-1,0),1.0,true],
		4 : [Vector2(1,0),2.0,false],
		5 : [Vector2(-1,0),1.0,true]
	},
	{
		0 : [Vector2(-1,-1),2.0,false],
		1 : [Vector2(1,1),2.0,true],
		2 : [Vector2(-1,0),2.0,false],
		3 : [Vector2(1,0),2.0,true],
		4 : [Vector2(-1,1),2.0,false],
		5 : [Vector2(1,-1),1.0,true]
	}
	]

func _init():
	health = 50
	accel = 4


func _ready() -> void:
	set_move()
	emit_signal("BossAwake", health)
	pass


func set_move() -> void:
	cur = move_boss[int(phase)].get(count)
	if cur[2]:
		can_fire()
	$Timer.start(cur[1]); yield($Timer, "timeout")
	#print(count)
	count += 1
	if count >= move_boss[int(phase)].size():
		count = 0
	set_move()
	pass

func can_fire() -> void:
	for n in rounds:
		var b = Master.bullet[3].instance()
		b.global_position = self.global_position - Vector2(19,0)
		b.proj = bullets
		get_parent().call_deferred("add_child",b)
		$RoundTimer.start(0.3); yield($RoundTimer,"timeout")
	pass

func take_damage(hp : int) -> void:
	health -= hp
	emit_signal("BossHealth", health)
	if health < health/2 and not phase:

		phase = true
	if health <= 0:
		explode()
	pass

func phase_two():
		global_position = Vector2(192,72)
		accel += 1
		rounds = 4
		bullets = 4

func _on_Enemy_body_entered(body):
	var player := body as Ship
	if player:
		player.dead = true
		print("OH NOOOOOOOO!!!")
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
