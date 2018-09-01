extends KinematicBody2D

signal bullet_impact

var speed = 2
var direction = Vector2(0, 0)
var isDead = false

func _physics_process(delta):
	var collision = move_and_collide(direction * speed)
	if collision == null: return
	
	if collision.collider.name == "PlayerCharacter":
		emit_signal("bullet_impact")
		
	isDead = true