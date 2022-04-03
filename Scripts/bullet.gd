class_name Bullet
extends Area2D

var fire_rate : float
var speed : float
var dmg : int
var life : int = 0
var life_time : int = 200

const explosion = preload("res://Prefabs/Explosion.tscn")
enum type_bullet {SINGLE = 1, CHARGE = 2, SPREAD = 3}

func _physics_process(_delta):
	bullet_movement()

func bullet_movement() -> void:
	life += 1
	position += Vector2(1,0).normalized() * speed
	if life > life_time:
		create_explosion()


func create_explosion() -> void:
	var e = explosion.instance()
	e.global_position = self.global_position
	get_parent().call_deferred("add_child",e)
	queue_free()
