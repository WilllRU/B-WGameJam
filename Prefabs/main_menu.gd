extends Control


func _ready():
	$Sprite.play("default"); yield($Sprite, "animation_finished")
	$Sprite.play("loop")

func _on_PlayButton_pressed():
	var _g = get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.

func _on_QuitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.
