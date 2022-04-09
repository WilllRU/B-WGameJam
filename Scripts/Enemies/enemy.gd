class_name Enemy
extends Hazard

## Starting frame loop, Key is the starting frame, 
var move_path : Dictionary = { 0 : [Vector2(-1,0),0.0,false]}
var count : int = 0
var cur : Array = [Vector2(0,0),0.0,false]

func take_damage(hp : int) -> void:
	health -= hp
	if health <= 0:
		explode()
	pass

func movement(move : Vector2, _d: float) -> void:
#	var new_pos = (move * accel) + position 
#	position = position.linear_interpolate(new_pos, d * accel)
	move *= accel/10
	position += move
