extends Enemy


func _init():
	health = 6
	accel = .5
	max_speed = 50
	# There is no "0" Key because we want this too loop
	# It won't break because the "cur" Array is filled with
	# a nuetral state
	move_path = {
		"40" : [Vector2(0,1),false],
		"80" : [Vector2(1,0),false],
		"120" : [Vector2(0,-1),false],
		"160" : [Vector2(-1,0),false]
	}
	

func _physics_process(_delta):
	enemy_load()
	enemy_action()
	pass

func enemy_load() -> void:
	count += 1
	var test = move_path.get(String(count))
	if test != null:
		cur = test
		size += 1
	if size >= move_path.size():
		count = 0
		size = 0
		pass
	#print(count)

func enemy_action() -> void:
	var vec2 : Vector2 = cur[0]
	movement(vec2)
	if cur[1]:
		print("SHOOTING!")
		#can_shoot()

func _on_Enemy_body_entered(body):
	var player := body as Ship
	if player:
		player.dead = true
		print("OH NOOOOOOOO!!!")
	pass # Replace with function body.
