extends Node2D


var load_data : Dictionary = Dictionary()
var num : int = 0
var count : int = 0

var firing : bool = false 

var bullet = [preload("res://BulletTypes/NormalBullet.tscn")]
var cur_bullet : int = 0


func _ready():
	load_data = load_file()

func load_file():
	var f := File.new()
	f.open("res://Ghost/" + "ghost_" + String(num) + ".json", File.READ)
	var result := JSON.parse(f.get_as_text())
	f.close()
	return result.result as Dictionary
	
func _physics_process(_delta):
	get_recording()
	pass
	
func get_recording():
	count += 1
	var test = load_data.get(String(count))
	if(test != null):
		global_position = str2var("Vector2" + test[0])
		if test[1]:
			can_shoot()
		if test[3]:
			create_explosion()

func can_shoot() -> void:
	if firing:
		return
	print("FIRE!")
	firing = true
	
	var l_b = bullet[cur_bullet].instance()
	l_b.global_position =  self.global_position + Vector2(5,0)
	get_parent().call_deferred("add_child",l_b)
	yield(get_tree().create_timer(l_b.fire_rate, false),"timeout")
	firing = false
	
func create_explosion() -> void:
	for n in 4:
		var explosion = preload("res://Prefabs/Explosion.tscn")
		var e = explosion.instance()
		e.global_position = self.global_position
		e.scale += Vector2(n, n)
		get_parent().call_deferred("add_child",e)
		yield(get_tree().create_timer(0.2, false),"timeout")
		
	queue_free()
