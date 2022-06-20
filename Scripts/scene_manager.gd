extends Node2D


var title : Array = ["Bypass the asteroids", "Get past the infantry", "Destroy The command ship"]


func _ready():
	tween_transition(Vector2(0,160))
	$Timer.start(.5); yield($Timer, "timeout")
	set_hud("Phase " + String(Master.level + 1) +":\n" +title[Master.level], 8)
	$Timer.start(.5); yield($Timer, "timeout")
	var s = Master.par.instance()
	s.obj = Master.ship
	s.global_position = Vector2(128,72)
	$LevelObjects.call_deferred("add_child",s)
	set_connect()
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			$CanvasLayer/Control/ColorRect.show()
			get_tree().paused = true

func tween_transition(target: Vector2):
	var s = $CanvasLayer/Control/Sprite
	var t = s.get_node("Tween")
	print("pos: ", position)
	t.interpolate_property(s, "position", position, target, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	t.start()
	pass

func set_hud(hud : String, l : int):
	hud = hud.to_upper()
	var t = $CanvasLayer/Control/HUD
	var c : Array = [" -", "- "]
	t.show()
	for n in l:
		t.bbcode_text = "[center]" + c[n%2].repeat(40) +"\n {1} \n".format({ 1 : hud}) + c[n%2].repeat(40)
		$Timer.start(0.2); yield($Timer, "timeout")
	t.hide()
	

func set_connect():
	$Timer2.start(2.1); yield($Timer2, "timeout")
	var sh = $LevelObjects.get_node("PlayerShip")
	sh.connect("RestartScene",self,"_on_PlayerShip_RestartScene")
	sh.connect("LevelComplete", self,"on_level_complete")
	
func _on_PlayerShip_RestartScene():
	#tween_transition(Vector2(0,0))
	$Timer.start(1.8); yield($Timer, "timeout")
	var _rl = get_tree().reload_current_scene()
	pass
func on_level_complete():
	Master.level += 1
	if Master.level < Master.lvls.size():
		$LevelObjects.start_level()
		set_hud("Phase " + String(Master.level + 1) +":\n" +title[Master.level],10)
	else:
		set_hud("MISSION COMPLETE!\n Thank you for playing!", 14);
		$Timer.start(2); yield($Timer, "timeout")
		var _nl = get_tree().change_scene("res://MainMenu.tscn")
