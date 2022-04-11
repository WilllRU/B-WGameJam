class_name MiniBoss
extends Enemy


var rounds : int = 3
var bullets : int = 3
var phase : bool = false

func explode() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	for n in 8:
		var e = Master.big_explosion.instance()
		e.global_position = self.global_position + Vector2(rand_range(-15,15),rand_range(-15,15))
		get_parent().call_deferred("add_child",e)
		yield(get_tree().create_timer(0.3, false),"timeout")
	var e = Master.big_explosion.instance()
	e.global_position = self.global_position + Vector2(rand_range(-15,15),rand_range(-15,15))
	get_parent().call_deferred("add_child",e)
	e.scale += Vector2(5,5)
	queue_free()
