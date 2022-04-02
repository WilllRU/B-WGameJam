extends Area2D


var fire_rate : float = 0.2
export var speed : float = 2
var dmg : int = 2
const life_time : int = 200
var explosion = preload("res://Prefabs/Explosion.tscn")

var count : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	count += 1
	position.x += speed
	if count > life_time:
		create_explosion()

func _on_bullet_body_entered(_body):
	create_explosion()
	pass # Replace with function body.

func _on_bullet_area_entered(_area):
	create_explosion()
	pass # Replace with function body.

func create_explosion() -> void:
	
	var e = explosion.instance()
	e.global_position = self.global_position
	get_parent().call_deferred("add_child",e)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
