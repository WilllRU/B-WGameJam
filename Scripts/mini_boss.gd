extends Enemy

var rounds : int = 3

func _init():
	health = 50
	accel = 4
	
	move_path = {
		0 : [Vector2(0,-1),2.0,false],
		1 : [Vector2(0,1),4.0,true],
		2 : [Vector2(0,-1),2.0,true],
		3 : [Vector2(-1,0),1.0,true],
		4 : [Vector2(1,0),2.0,false],
		5 : [Vector2(-1,0),1.0,true]
	}


func _ready() -> void:
	set_move()
	pass

func set_move() -> void:
	cur = move_path.get(count)
	if cur[2]:
		can_fire()
	$Timer.start(cur[1]); yield($Timer, "timeout")
	#print(count)
	count += 1
	if count >= move_path.size():
		count = 0
	set_move()
	pass

func can_fire() -> void:
	var b = Master.bullet[3].instance()
	b.global_position = self.global_position - Vector2(19,0)
	for n in rounds:
		b.proj = 3
		get_parent().call_deferred("add_child",b)
		
	
	pass

func _physics_process(_delta):
	movement(cur[0], _delta)

func _on_Enemy_body_entered(body):
	var player := body as Ship
	if player:
		player.dead = true
		print("OH NOOOOOOOO!!!")
	pass # Replace with function body.
