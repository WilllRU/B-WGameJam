extends Node2D

func _ready():
	
	set_hud("Ready?")
	$Timer.start(.5); yield($Timer, "timeout")
	var s = Master.par.instance()
	s.global_position = Vector2(128,72)
	$LevelObjects.call_deferred("add_child",s)
	pass

func set_hud(hud : String):
	hud = hud.to_upper()
	var t = $CanvasLayer/Control/HUD
	var c : Array = [" -", "- "]
	t.show()
	for n in 6:
		t.bbcode_text = "[center]" + c[n%2].repeat(40) +"\n {1} \n".format({ 1 : hud}) + c[n%2].repeat(40)
		$Timer.start(0.2); yield($Timer, "timeout")
	t.hide()
	$Timer.start(1.5); yield($Timer, "timeout")
	var sh = $LevelObjects.get_node("PlayerShip")
	sh.connect("RestartScene",self,"_on_PlayerShip_RestartScene")
	
func _on_PlayerShip_RestartScene():
	$Timer.start(2.0); yield($Timer, "timeout")
	get_tree().reload_current_scene()
	pass
