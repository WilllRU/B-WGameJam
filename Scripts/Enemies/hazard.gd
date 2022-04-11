class_name Hazard
extends Area2D

var health : int
var accel : float = 10

var c_dir := Vector2(0,0)


func take_damage(hp : int) -> void:
	health -= hp
	if health <= 0:
		explode()
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
	

