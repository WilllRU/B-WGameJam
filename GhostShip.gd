extends Node2D


var load_data : Dictionary = Dictionary()
var num : int = 0
var count : int = 0


func _ready():
	load_data = load_file()

func load_file():
	var f := File.new()
	f.open("res://Ghost/" + "ghost_" + String(num) + ".json", File.READ)
	var result := JSON.parse(f.get_as_text())
	f.close()
	return result.result as Dictionary
	
func _physics_process(delta):
	get_recording()
	pass
	
func get_recording():
	count += 1
	var test = load_data.get(String(count))
	if(test != null):
		global_position = str2var("Vector2" + test[0])
		print("Fire: ", test[1])
