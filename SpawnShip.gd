extends CPUParticles2D

var obj = Master.miniboss

func _ready():
	var r = 256/144
	var pos : Vector2 = global_position
	pos.x = pos.x / 256;
	pos.x = (pos.x - 0.5) / r + 0.5;
	pos.y = (144 - pos.y) / 144;
	#var pos = self.global_position/Vector2(256,144)
	$CanvasLayer/ColorRect.material.set_shader_param("center", pos)
	$Timer.start(2.0); yield($Timer, "timeout")
	var s = obj.instance()
	s.global_position = self.global_position
	get_parent().call_deferred("add_child",s)
	$Timer.start(1.0); yield($Timer, "timeout")
	queue_free()
	
