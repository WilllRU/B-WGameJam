class_name Enemy
extends Area2D

var health : int

func take_damage(hp : int) -> void:
	health -= hp
	if health <= 0:
		explode()
	pass

func explode() -> void:
	monitoring = false
	monitorable = false
	for n in 2:
		var explosion = preload("res://Prefabs/Explosion.tscn")
		var e = explosion.instance()
		e.global_position = self.global_position
		e.scale += Vector2(n, n) * 2
		get_parent().call_deferred("add_child",e)
		yield(get_tree().create_timer(0.2, false),"timeout")
	queue_free()
	

