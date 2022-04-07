class_name Bullet
extends Area2D

var fire_rate : float = 0
var speed : float = 0
var dmg : int = 0
var vec_dir := Vector2(1,0)

enum type_bullet {SINGLE = 1, CHARGE = 2, SPREAD = 3}

func _physics_process(_delta):
	bullet_movement()

func bullet_movement() -> void:
	position += vec_dir.normalized() * speed


func create_explosion() -> void:
	var e = Master.explosion.instance()
	e.global_position = self.global_position
	get_parent().call_deferred("add_child",e)
	queue_free()
