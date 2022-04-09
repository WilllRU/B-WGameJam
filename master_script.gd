extends Node2D

var asteroid = preload("res://Prefabs/Enemies/Asteroid.tscn")
var explosion = preload("res://Prefabs/Explosion.tscn")
var big_explosion = preload("res://Prefabs/BigExplosion.tscn")
var par = preload("res://Prefabs/Ships/ChargeParticles.tscn")
var ship = preload("res://Prefabs/Ships/PlayerShip.tscn")

# BulletTypes
onready var bullet : Array = [
	preload("res://BulletTypes/NormalBullet.tscn"),
	preload("res://BulletTypes/TripleBullet.tscn"),
	preload("res://BulletTypes/ChargeShot.tscn")
	]
onready var spread = preload("res://BulletTypes/SpreadBullet.tscn")
var ghost = preload("res://Prefabs/Ships/GhostShip.tscn")

onready var hazard : Array = [
	preload("res://Prefabs/Enemies/Asteroid.tscn"),
	preload("res://Prefabs/Enemies/Drone.tscn")
]

var loop : int = 0
