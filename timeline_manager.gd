extends Node2D

onready var prefab : Array = [
	preload("res://Prefabs/Drone.tscn")
]

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
	0 : [2.0,prefab[0],3,8,40],
	1 : [2.0,prefab[0],3,24,40],
	2 : [2.0,prefab[0],3,8,40]
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
	for n in cur[2]:
		var e = cur[1].instance()
		e.global_position = Vector2(288, cur[3] + (cur[4] * n))
		get_parent().call_deferred("add_child",e)
	if count < timeline.size():
		play_timeline()
	pass
