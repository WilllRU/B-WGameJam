extends Node2D

var asteroid = preload("res://Prefabs/Enemies/Asteroid.tscn")
var explosion = preload("res://Prefabs/Explosion.tscn")
var big_explosion = preload("res://Prefabs/BigExplosion.tscn")
var par = preload("res://Prefabs/Ships/ChargeParticles.tscn")
var ship = preload("res://Prefabs/Ships/PlayerShip.tscn")
var powerups : Array = [
	preload("res://Prefabs/BulletInc.tscn"),
	preload("res://Prefabs/BulletRate.tscn")
]
var miniboss = preload("res://Prefabs/MiniBoss/MiniBoss.tscn")
var portal = preload("res://Prefabs/Ships/PortalParticles.tscn")

# BulletTypes
onready var bullet : Array = [
	preload("res://BulletTypes/NormalBullet.tscn"),
	preload("res://BulletTypes/TripleBullet.tscn"),
	preload("res://BulletTypes/ChargeShot.tscn"),
	preload("res://BulletTypes/EnemySpreadBullet.tscn")
	]
onready var spread = [
	preload("res://BulletTypes/SpreadBullet.tscn"),
	preload("res://BulletTypes/EnemyBullet.tscn")
	]

onready var complete = preload("res://Prefabs/LevelComplete.tscn")

onready var lvls = [
	preload("res://Prefabs/Levels/Level1.tscn"),
	preload("res://Prefabs/Levels/Level1.tscn"),
	preload("res://Prefabs/Levels/Level3.tscn")
	]

onready var ghost = preload("res://Prefabs/Ships/GhostShip.tscn")

onready var hazard : Array = [
	preload("res://Prefabs/Enemies/Asteroid.tscn"),
	preload("res://Prefabs/Enemies/Drone.tscn"),
	preload("res://Prefabs/Enemies/DynaBall.tscn")
]

var loop : int = 0
var level : int = 0
