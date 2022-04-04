class_name Enemy
extends Area2D

var health : int
var accel : float
var max_speed : int
# Starting frame loop, Key is the starting frame, 
var move_path : Dictionary = {"0": [Vector2(-1,0),false]}
var count : int = 0
var cur : Array = [Vector2(0,0),false]
var size : int

func take_damage(hp : int) -> void:
	health -= hp
	if health <= 0:
		explode()
	pass

func movement(move : Vector2) -> void:
	move *= accel
	move = Vector2(clamp(move.x, -max_speed, max_speed), clamp(move.y, -max_speed, max_speed))
	position += move

func explode() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	for n in 2:
		var explosion = preload("res://Prefabs/Explosion.tscn")
		var e = explosion.instance()
		e.global_position = self.global_position
		e.scale += Vector2(n, n) * 2
		get_parent().call_deferred("add_child",e)
		yield(get_tree().create_timer(0.2, false),"timeout")
	queue_free()
	
