extends CPUParticles2D

func _ready():
	$Timer.start(2.0); yield($Timer, "timeout")
	var s = Master.ship.instance()
	s.global_position = self.global_position
	get_parent().call_deferred("add_child",s)
	$Timer.start(1.0); yield($Timer, "timeout")
	queue_free()
