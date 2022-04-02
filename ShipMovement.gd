extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Ship Vars
var accel: int = 5
var maxSpeed : int = 90
var dir : Vector2 = Vector2(0,0)
var damping : float = 1
var firing : bool = false
var fired : bool = false
var bomb : bool = false
var dead : bool = false

#var bullet : 

# Recording for the Ghost
var count : int = 0
var curGhost : int = 0
const maxGhost : int = 3

# Ghost Data: [0]Dir, [1]Fired, [2]Used bomb, [3]Died
var ghost_play : Dictionary = {"0": [Vector2(0,0), false, false, false]}


# Called when the node enters the scene tree for the first time.
func _ready():
	SetupGhost()
	pass # Replace with function body.

func SetupGhost() -> void:
	var file_check = File.new()
	for n in maxGhost:
		if file_check.file_exists("res://Ghost/" + "ghost_" + String(n) + ".json"):
			var ghost = preload("res://Prefabs/GhostShip.tscn")
			var load_ghost = ghost.instance()
			load_ghost.global_position = self.global_position
			get_parent().call_deferred("add_child",load_ghost)
	pass


func RecordGhost() -> void:
	count += 1
	ghost_play[String(count)] = [global_position, fired, bomb, dead]
	if(Input.is_action_just_pressed("game_bomb")):
		var f := File.new()
		f.open("res://Ghost/" + "ghost_" + String(curGhost) + ".json", File.WRITE)
		prints("Saving to", f.get_path_absolute())
		f.store_string(JSON.print(ghost_play))
		f.close()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
	dir = Vector2(clamp(dir.x, -maxSpeed, maxSpeed), clamp(dir.y, -maxSpeed, maxSpeed))
	pass

func CanShoot() -> void:
	if firing:
		return
	print("FIRE!")
	firing = true
	# Spawn in bullet
	# Wait predetermined time to shoot bullet again depedent on
	# var of the bullet.
	firing = false
	

func _integrate_forces(state):
	state.linear_velocity = TrueSpeed()
	pass
	
func TrueSpeed() -> Vector2:
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
	RecordGhost()
	if fired:
		fired = false
		CanShoot()
