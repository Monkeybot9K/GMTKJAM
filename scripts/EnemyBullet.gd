extends KinematicBody2D

signal bullet_impact

var speed = 350
var direction = Vector2(0, 0)
var isDead = false

func set_direction(new_direction):
	direction = new_direction
	if direction.x > 0:
		$Sprite.rotation_degrees = -90
	elif direction.x < 0:
		$Sprite.rotation_degrees = 90
	elif direction.y < 0:
		$Sprite.rotation_degrees = 180
	else:
		$Sprite.rotation_degrees = 0
	return
	

func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if collision == null: return
	
	if collision.collider.name == "PlayerCharacter":
		emit_signal("bullet_impact")
		
	isDead = true