extends Enemy

var rounds : int = 3

func _init():
	health = 4
	accel = 4
	
	move_path = {
		0 : [Vector2(0,1),2.0,true],
		1 : [Vector2(-1,0),0.4,false],
		2 : [Vector2(0,-1),2.0,true],
		3 : [Vector2(-1,0),0.4,false]
	}
func _ready() -> void:
	set_move()
	pass

func can_fire() -> void:
	for n in rounds:
		var b = Master.bullet[3].instance()
		b.global_position = self.global_position - Vector2(10,0)
		b.proj = 1
		get_parent().call_deferred("add_child",b)
		$RoundTimer.start(0.3); yield($RoundTimer,"timeout")
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


func _on_Enemy_body_entered(body):
	var player := body as Ship
	if player:
		player.dead = true
		print("OH NOOOOOOOO!!!")
	pass # Replace with function body.
