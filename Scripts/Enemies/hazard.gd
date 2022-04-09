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
		var e = Master.big_explosion.instance()
		e.global_position = self.global_position
		#e.scale += Vector2(n, n) * 2
		get_parent().call_deferred("add_child",e)
		yield(get_tree().create_timer(0.2, false),"timeout")
	queue_free()
	

