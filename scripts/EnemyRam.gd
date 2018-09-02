extends KinematicBody2D

onready var player_character = get_parent().get_node("PlayerCharacter")

export var downtime_after_attack = 5
export var movement_speed = 50
export var ramming_speed = 400

var isActive = false
var isRamming = false
var motion = Vector2()
var downtime_timer = 0

#If player is spotted, Activate the enemy
func _on_Area2D_body_entered(body):	
	if body.name == "PlayerCharacter":
		isActive = true

#Wander around in search of the player
func random_motion():
	return Vector2(rand_range(-1,1), rand_range(-1,1)).normalized() * movement_speed

#Go straight toward the player's position
func ramming_motion():
	isRamming = true
	return (player_character.position - self.position).normalized() * ramming_speed

func _physics_process(delta):
	#If inactive, do nothing
	if isActive == false:
		return

	#If on downtime, count down
	if downtime_timer > 0:
		downtime_timer -= delta
		return
	else:
		#If no longer in downtime, and no heading, start moving toward a random one
		if motion.length() == 0:
			motion = random_motion()

	#if player is spotted, ram them
	if !isRamming:
		for body in $ViewArea.get_overlapping_bodies():
			if body.name == "PlayerCharacter":
				motion = ramming_motion()
				break

	#Rotate toward heading
	
	if abs(motion.y) > abs(motion.x):
		if motion.y < 0:
			$Sprite.frame = 3
			$ViewArea.rotation_degrees = -90
		else:
			$Sprite.frame = 0
			$ViewArea.rotation_degrees = 90
	else:
		if motion.x < 0:
			$Sprite.frame = 1
			$ViewArea.rotation_degrees = 180
		else:
			$Sprite.frame = 2
			$ViewArea.rotation_degrees = 0

	#Perform current motion and, if collision occurs stop motion, engage downtime
	var collision = move_and_collide(motion * delta)
	if collision != null:
		if isRamming:
			downtime_timer = downtime_after_attack
			isRamming = false
		if collision.collider.name == "PlayerCharacter":
			GameState.HitCharacter(1, motion.normalized())
		motion = Vector2()
