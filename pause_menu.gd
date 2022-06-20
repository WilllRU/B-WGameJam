extends ColorRect


func _on_ResumeButton_pressed():
	self.hide()
	get_tree().paused = false
	pass # Replace with function body.


func _on_MenuButton_pressed():
	get_tree().paused = false
	var _m = get_tree().change_scene("res://MainMenu.tscn")
	pass # Replace with function body.
