extends Node2D

# [0] When to be Spawned,
# [1] The object to be Spawned, 
# [2] The amount Spawned(along the Y axis)
# [3] The starting spawnpoint
# (if multiple, they'll spawn below it by [4])
#
#
#
# [4] Distance between multiple instances
#
onready var timeline : Dictionary = {
	
	0 : [2.0, Master.hazard[0], 1, 128, 0],
	1 : [4.0, Master.hazard[0], 1, 112, 0],
	2 : [2.0, Master.hazard[0], 1, 16, 0],
	3 : [4.0, Master.hazard[0], 1, 80, 0],
	4 : [2.0, Master.hazard[0], 1, 128, 0],
	5 : [4.0, Master.hazard[0], 1, 32, 0],
	6 : [4.0, Master.hazard[0], 1, 80, 0],
	7 : [2.0, Master.hazard[0], 1, 16, 0],
	8 : [4.0, Master.hazard[1], 1, 32, 0],
	9 : [2.0, Master.hazard[0], 1, 112, 0],
	10 : [4.0, Master.hazard[0], 1, 32, 0],
	11 : [2.0, Master.hazard[1], 1, 128, 0],
	12 : [6.0, Master.hazard[0], 1, 72, 0],
	13 : [2.0, Master.hazard[1], 2, 16, 112],
	14 : [4.0, Master.hazard[0], 1, 64, 0],
	15 : [2.0, Master.hazard[1], 1, 96, 0],
	16 : [2.0, Master.hazard[0], 1, 32, 0],
	17 : [0.0, Master.hazard[1], 1, 128, 0],
	18 : [2.0, Master.hazard[1], 2, 48, 48],
	19 : [2.0, Master.hazard[0], 1, 16, 0],
	20 : [0.0, Master.hazard[1], 1, 80, 0]
	
#	0 : [2.0,prefab[0],3,8,40],
#	1 : [2.0,null,3,24,40],
#	2 : [2.0,prefab[0],3,8,40]
}
var cur : Array
var count : int = 0





# Called when the node enters the scene tree for the first time.
func _ready():
	play_timeline()
	pass # Replace with function body.

func play_timeline() -> void:
	cur = timeline.get(count)
	$LevelTimer.start(cur[0]); yield($LevelTimer, "timeout")
	count += 1
	if cur[1] != null:
		for n in cur[2]:
			var e = cur[1].instance()
			e.global_position = Vector2(288, cur[3] + (cur[4] * n))
			get_parent().call_deferred("add_child",e)
	if count < timeline.size():
		play_timeline()
	pass
