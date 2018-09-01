extends Node2D

onready var bullet = preload("res://scenes/EnemyBullet.tscn")

var bullets = []

func _on_EnemyOwl_shoot(args):
	var b = bullet.instance()
	b.direction = args[0]
	b.position = args[1]
	bullets.push_back(b)
	add_child(b)
	
func _process(delta):
	for b in bullets:
		print(b)
