extends Node2D

# [0] When to be Spawned,
# [1] The object to be Spawned, 
# [2] The amount Spawned(along the Y axis)
# [3] The starting spawnpoint
# (if multiple, they'll spawn below it by [4])
# [4] Distance between multiple instances

onready var level = [{
	0 : [0.0, Master.hazard[1], 1, Vector2(288,112), 0],
	1 : [6.0, Master.hazard[1], 1, Vector2(288,32), 0],
	2 : [6.0, Master.hazard[1], 1, Vector2(288,72), 0],
	3 : [8.0, Master.hazard[1], 2, Vector2(288,32), 48],
	4 : [6.0, Master.hazard[1], 1, Vector2(288,80), 0],
	5 : [4.0, Master.hazard[1], 1, Vector2(288,112), 0],
	6 : [6.0, Master.hazard[1], 1, Vector2(288,32), 0],
	7 : [6.0, Master.hazard[1], 1, Vector2(288,72), 0],
	8 : [6.0, Master.hazard[1], 2, Vector2(288,32), 64],
	9 : [4.0, Master.hazard[1], 1, Vector2(288,80), 0],
	10 : [6.0, Master.hazard[1], 2, Vector2(288,48), 64],
	11 : [4.0, Master.hazard[1], 2, Vector2(288,32), 64],
	12 : [4.0, Master.hazard[1], 2, Vector2(288,16), 64],
	13 : [4.0, Master.hazard[1], 3, Vector2(288,32), 48],
	14 : [4.0, Master.hazard[1], 3, Vector2(288,16), 48],
	15 : [10.0, Master.par, 1, Vector2(192,72), 48]
},
{
	0:[6.0, Master.par, 1, Vector2(192,72), 48]
	
}]


var timeline : Dictionary
var cur : Array
var count : int = 0





# Called when the node enters the scene tree for the first time.
func _ready():
	start_level()
	pass # Replace with function body.

func start_level():
	timeline = level[Master.level]
	var lv = Master.lvls[Master.level].instance()
	lv.global_position = self.global_position
	call_deferred("add_child", lv)
	play_timeline()

func play_timeline() -> void:
	cur = timeline.get(count)
	$LevelTimer.start(cur[0]); yield($LevelTimer, "timeout")
	count += 1
	if cur[1] != null:
		for n in cur[2]:
			var e = cur[1].instance()
			e.global_position = Vector2(cur[3].x, cur[3].y + (cur[4] * n))
			get_parent().call_deferred("add_child",e)
	if count < timeline.size():
		play_timeline()
	pass
