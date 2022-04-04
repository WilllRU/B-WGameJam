extends Ship

signal RestartScene

# Recording for the Ghost
var old : Array 

func _init():
	accel = 5
	max_speed = 90
	damping = 1.5
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_ghost()
	pass # Replace with function body.

func setup_ghost() -> void:
	var file_check = File.new()
	for n in max_ghost:
		if file_check.file_exists("user://" + "ghost_" + String(n) + ".json"):
			var ghost = preload("res://Prefabs/Ships/GhostShip.tscn")
			var load_ghost = ghost.instance()
			load_ghost.global_position = global_position
			get_parent().call_deferred("add_child",load_ghost)
	pass


func record_ghost() -> void:
	count += 1
	var new : Array = [p_dir, fired, bomb, dead]
	if new != old:
		old = new
		#print(new, " : ", old)
		ghost_play[String(count)] = new
		frame = 0
		return

func movement_manager() -> void:
	p_dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down",-2)
	if Input.is_action_pressed("game_fire") and not firing:
		fired = true
		pass
	
	cur_speed += p_dir * accel 
	cur_speed = Vector2(
		clamp(cur_speed.x, -max_speed, max_speed),
		clamp(cur_speed.y, -max_speed, max_speed)
		)

func _integrate_forces(state):
	state.linear_velocity = true_speed()
	pass
	
func true_speed() -> Vector2:
	if cur_speed.x > 0:
		cur_speed.x -= damping
	if cur_speed.x < 0:
		cur_speed.x += damping
	if cur_speed.y > 0:
		cur_speed.y -= damping
	if cur_speed.y < 0:
		cur_speed.y += damping
	return cur_speed

func _physics_process(_delta):
	if not dead:
		movement_manager()
	record_ghost()
	if fired:
		fired = false
		can_shoot()
	if dead and not is_dying:
		is_dying = true
		has_died()
		
func has_died() -> void:
	
	var f := File.new()
	f.open("user://" + "ghost_0.json", File.WRITE)
	prints("Saving to", f.get_path_absolute())
	f.store_string(JSON.print(ghost_play))
	f.close()
	
	emit_signal("RestartScene")
	create_explosion()
