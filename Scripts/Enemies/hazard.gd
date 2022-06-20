class_name Hazard
extends Area2D

onready var shader = preload("res://Prefabs/Enemies/HitFlash.tres").duplicate(true)

var health : int
var accel : float = 10

var c_dir := Vector2(0,0)

func _ready():
	$Sprite.set_material(shader)
	var f_t = Timer.new()
	f_t.name = "FlashTime"
	call_deferred("add_child", f_t)

func take_damage(hp : int) -> void:
	health -= hp
	if health <= 0:
		explode()
	$Sprite.material.set_shader_param("hit_opacity", 1)
	$FlashTime.start(0.1); yield($FlashTime, "timeout")
	$Sprite.material.set_shader_param("hit_opacity", 0)
	pass


func explode() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	for n in 2:
		var e = Master.explosion.instance()
		e.global_position = self.global_position
		get_parent().call_deferred("add_child",e)
		$Timer.start(0.2);yield($Timer,"timeout")
	queue_free()
	

