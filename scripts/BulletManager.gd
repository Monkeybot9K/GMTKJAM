extends Node2D

onready var bullet = preload("res://scenes/EnemyBullet.tscn")

onready var player_character = get_parent().get_node("PlayerCharacter")

var lives = 3
var bullets = []

func _on_EnemyOwl_shoot(args):
	var b = bullet.instance()
	b.set_direction(args[0])
	b.position = args[1]
	bullets.push_back(b)
	b.connect("bullet_impact", self, "update_lives")
	add_child(b)
	
func update_lives():
	GameState.SetLives(GameState.Lives - 1)
	
func _process(delta):
	var removeBullets = []
	for b in bullets:
		if b.isDead:
			removeBullets.push_back(bullets.find(b))
			b.disconnect("bullet_impact", self, "update_lives")
			remove_child(b)
			
	for i in removeBullets:
		bullets.remove(i)
