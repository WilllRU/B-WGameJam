extends Enemy

func _init():
	health = 4
	accel = 2.8 * 2
	
	move_path = {
		0 : [Vector2(-1,1),1.0,false],
		1 : [Vector2(-1,0),0.4,false],
		2 : [Vector2(-1,-1),1.0,false],
		3 : [Vector2(-1,0),0.4,false]
	}
func _ready() -> void:
	set_move()
	pass

func set_move() -> void:
	cur = move_path.get(count)
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
