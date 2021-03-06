class_name Enemy
extends Hazard

## Starting frame loop, Key is the starting frame, 
var move_path : Dictionary = { 0 : [Vector2(-1,0),0.0,false]}
var count : int = 0
var cur : Array = [Vector2(0,0),0.0,false]


func explode() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	for n in 2:
		var e = Master.big_explosion.instance()
		e.global_position = self.global_position
		#e.scale += Vector2(n, n) * 2
		get_parent().call_deferred("add_child",e)
		yield(get_tree().create_timer(0.2, false),"timeout")
	spawn_item()
	queue_free()

func _physics_process(_delta):
	movement(cur[0], _delta)

func spawn_item() -> void:
	var r : int = randi() % 14
	if r < Master.powerups.size():
		var pu = Master.powerups[r].instance()
		pu.global_position = self.global_position
		get_parent().call_deferred("add_child",pu)
	pass

func movement(move : Vector2, _d: float) -> void:
#	var new_pos = (move * accel) + position 
#	position = position.linear_interpolate(new_pos, d * accel)
	move *= accel/10
	position += move
