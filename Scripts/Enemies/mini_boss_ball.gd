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
		5 : [Vector2(1,-1),2.0,true]
	}
	]

var max_health = 75
var started_phase = false

func _init():
	health = max_health
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
	if phase and not started_phase:
		started_phase = true
		phase_two()
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
	if health < max_health/2 and not phase:
		phase = true
		set_deferred("monitoring", false)
		set_deferred("monitorable", false)
	if health <= 0:
		var c = Master.complete.instance()
		c.global_position = Vector2(288,72)
		get_parent().call_deferred("add_child",c)
		explode()
	$Sprite.material.set_shader_param("hit_opacity", 1)
	$FlashTime.start(0.2); yield($FlashTime, "timeout")
	$Sprite.material.set_shader_param("hit_opacity", 0)
	pass

func phase_two():
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	cur[0] = Vector2(0,0)
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
