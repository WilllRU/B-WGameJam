class_name Ship
extends RigidBody2D


# Ship Vars
var accel: int = 0
var cur_speed := Vector2(0,0)
var max_speed : int = 0
var p_dir := Vector2(0,0)
var damping : float = 0
var firing : bool = false
var fired : bool = false
var bomb : bool = false
var is_dying : bool = false
var dead : bool = false

onready var explosion = preload("res://Prefabs/Explosion.tscn")
# BulletTypes
onready var bullet = [preload("res://BulletTypes/NormalBullet.tscn"), preload("res://BulletTypes/TripleBullet.tscn")]
var cur_bullet : int = 0

var cur_ghost : int = 0
const max_ghost : int = 3

# Recording for the Ghost
var frame : int = 0
var count : int = 0

# Ghost Data: [0]Frames, [1]cur_speed, [2]Fired, [3]Used bomb, [4]Died
var ghost_play : Dictionary = {"0": [0, Vector2(0,0), false, false, false]}

func can_shoot() -> void:
	if firing:
		return
	#print("FIRE!")
	firing = true
	var l_b = bullet[cur_bullet].instance()
	l_b.global_position = global_position + Vector2(15,0)
	get_parent().call_deferred("add_child",l_b)
	$Timer.start(l_b.fire_rate); yield($Timer, "timeout")
	firing = false


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
	
func create_explosion() -> void:
	for n in 4:
		var e = explosion.instance()
		e.global_position = global_position
		e.scale += Vector2(n, n)
		get_parent().call_deferred("add_child",e)
		$Timer.start(0.2); yield($Timer, "timeout")
	queue_free()
