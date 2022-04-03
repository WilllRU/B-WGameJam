class_name ShipMovement
extends RigidBody2D

# Ship Vars
var accel: int = 5
var max_speed : int = 90
var dir : Vector2 = Vector2(0,0)
var damping : float = 1.5
var firing : bool = false
var fired : bool = false
var bomb : bool = false
var is_dying : bool = false
var dead : bool = false

# BulletTypes
var bullet = [preload("res://BulletTypes/NormalBullet.tscn"), preload("res://BulletTypes/TripleBullet.tscn")]
var cur_bullet : int = 1

# Recording for the Ghost
var count : int = 0
var cur_ghost : int = 0
const max_ghost : int = 3

# Ghost Data: [0]Dir, [1]Fired, [2]Used bomb, [3]Died
var ghost_play : Dictionary = {"0": [Vector2(0,0), false, false, false]}


# Called when the node enters the scene tree for the first time.
func _ready():
	setup_ghost()
	pass # Replace with function body.

func setup_ghost() -> void:
	var file_check = File.new()
	for n in max_ghost:
		if file_check.file_exists("res://Ghost/" + "ghost_" + String(n) + ".json"):
			var ghost = preload("res://Prefabs/GhostShip.tscn")
			var load_ghost = ghost.instance()
			load_ghost.num = n
			load_ghost.global_position = self.global_position
			get_parent().call_deferred("add_child",load_ghost)
	pass


func record_ghost() -> void:
	count += 1
	ghost_play[String(count)] = [global_position, fired, bomb, dead]
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not dead:
		movement_manager()
	pass

func movement_manager() -> void:
	if Input.is_action_pressed("ui_right"):
		dir.x += accel
		pass
	if Input.is_action_pressed("ui_left"):
		dir.x -= accel
		pass
	if Input.is_action_pressed("ui_down"):
		dir.y += accel
		pass
	if Input.is_action_pressed("ui_up"):
		dir.y -= accel
		pass
	if Input.is_action_pressed("game_fire") and not firing:
		fired = true
		pass
	dir = Vector2(clamp(dir.x, -max_speed, max_speed), clamp(dir.y, -max_speed, max_speed))

func can_shoot() -> void:
	if firing:
		return
	print("FIRE!")
	firing = true
	var l_b = bullet[cur_bullet].instance()
	l_b.global_position = self.global_position + Vector2(5,0)
	get_parent().call_deferred("add_child",l_b)
	yield(get_tree().create_timer(l_b.fire_rate, false),"timeout")
	firing = false
	

func _integrate_forces(state):
	state.linear_velocity = true_speed()
	pass
	
func true_speed() -> Vector2:
	if dir.x > 0:
		dir.x -= damping
	if dir.x < 0:
		dir.x += damping
	if dir.y > 0:
		dir.y -= damping
	if dir.y < 0:
		dir.y += damping
	return dir

func _physics_process(_delta):
	record_ghost()
	if fired:
		fired = false
		can_shoot()
	if dead and not is_dying:
		is_dying = true
		has_died()

func has_died() -> void:
	create_explosion()
	var f := File.new()
	f.open("res://Ghost/" + "ghost_" + String(cur_ghost) + ".json", File.WRITE)
	prints("Saving to", f.get_path_absolute())
	f.store_string(JSON.print(ghost_play))
	f.close()

func create_explosion() -> void:
	for n in 4:
		var explosion = preload("res://Prefabs/Explosion.tscn")
		var e = explosion.instance()
		e.global_position = self.global_position
		e.scale += Vector2(n, n)
		get_parent().call_deferred("add_child",e)
		yield(get_tree().create_timer(0.2, false),"timeout")
		
	queue_free()
	
