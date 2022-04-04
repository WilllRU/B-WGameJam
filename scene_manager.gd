extends Node2D

func _on_PlayerShip_RestartScene():
	$Timer.start(1.0); yield($Timer, "timeout")
	get_tree().reload_current_scene()
	pass
