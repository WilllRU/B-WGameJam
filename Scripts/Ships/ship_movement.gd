extends Ship
class_name Player

signal RestartScene
signal ShipPosition (pos)
signal LevelComplete

# Recording for the Ghost
var old : Array 

var ch_wait : float

func _init():
	#accel = 5
	#max_speed = 90
	#damping = 1.5
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
#	for n in max_ghost:
	if file_check.file_exists("user://" + "ghost_" + String(Master.level) + ".json"):
		var load_ghost = Master.ghost.instance()
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
	p_dir = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down")
	if not firing:
		fired = Input.is_action_pressed("game_fire")
#		if not fired:
#			charge_shot()
#		ch_wait += d
#		ch_wait *= float(fired)
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

func _process(_delta):
	emit_signal("ShipPosition", global_position)

func level_complete():
	emit_signal("LevelComplete")

func has_died() -> void:
	
	var f := File.new()
	var check = f.open("user://" + "ghost_" + String(Master.level) + ".json", File.WRITE)
	if check != OK:
		printerr("FAILED TO SAVE GHOST")
	prints("Saving to", f.get_path_absolute())
	f.store_string(JSON.print(ghost_play))
	f.close()
	create_explosion()
	emit_signal("RestartScene")
