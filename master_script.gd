extends Node2D

var asteroid = preload("res://Prefabs/Enemies/Asteroid.tscn")
var explosion = preload("res://Prefabs/Explosion.tscn")
var big_explosion = preload("res://Prefabs/BigExplosion.tscn")
# BulletTypes
onready var bullet : Array = [
	preload("res://BulletTypes/NormalBullet.tscn"),
	preload("res://BulletTypes/TripleBullet.tscn"),
	]
onready var spread = preload("res://BulletTypes/SpreadBullet.tscn")
var ghost = preload("res://Prefabs/Ships/GhostShip.tscn")

onready var hazard : Array = [
	preload("res://Prefabs/Enemies/Drone.tscn"),
	preload("res://Prefabs/Enemies/Asteroid.tscn")
]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
