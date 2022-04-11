extends Ship

var load_data : Dictionary = Dictionary()
var data_size : int = 0

var cur : Array

func _init():
	accel = 5
	max_speed = 90
	damping = 1.5

func _ready():
	load_data = load_file()
	data_size = load_data.size()

func load_file():
	var f := File.new()
	var check = f.open("user://" + "ghost_" + String(Master.level) + ".json", File.READ)
	if check != OK:
		printerr("The file is unsalvagable...WHAT DID YOU DO!!!!")
		pass
	var result := JSON.parse(f.get_as_text())
	f.close()
	return result.result as Dictionary

# Called every frame. 'delta' is the elapsed time since the previous frame.


func movement_manager(p_dir : Vector2):
	cur_speed += p_dir * accel 
	cur_speed = Vector2(clamp(cur_speed.x, -max_speed, max_speed), clamp(cur_speed.y, -max_speed, max_speed))

func _integrate_forces(state):
	state.linear_velocity = true_speed()
	#print(state.linear_velocity)
	pass

func _physics_process(_delta):
	get_recording()
	if not dead:
		play_recording()
	if dead and not is_dying:
		is_dying = true
		create_explosion()
	pass
	
func get_recording():
	count += 1
#	if count > data_size:
#		dead = true
#		return
	var test = load_data.get(String(count))
	if test != null:
		cur = test
func play_recording():
	var vec2 : Vector2 = str2var("Vector2" + cur[0])
	movement_manager(vec2)
	if cur[1]:
		#print("SHOOTING!")
		can_shoot()
	if cur[3]:
		dead = true
