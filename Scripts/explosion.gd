extends AnimatedSprite

func _ready():
	play("default")
	$Timer.start(1.0); yield($Timer, "timeout")
	queue_free()
	pass
