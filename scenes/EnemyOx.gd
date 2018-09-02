extends KinematicBody2D

onready var player_character = get_parent().get_node("PlayerCharacter")

export var downtime_after_attack = 5
export var movement_speed = 50
export var attack_speed = 300

var current_animation = "Down"
var isActive = false
var isAttacking = false
var motion = Vector2()
var downtime_timer = 0

#If player is spotted, Activate the enemy
func _on_ViewArea_body_entered(body):
	for body in $ViewArea.get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			isActive = true

#If player is in range and in view, attack
func _on_AttackRange_body_entered(body):
	if !isAttacking:
		return

	motion = Vector2()
	var player_direction = (player_character.position - position).normalized()
	
	if abs(player_direction.y) > abs(player_direction.x):

		if player_direction.y < 0:
			current_animation = "Axe_Up"
			$ViewArea.rotation_degrees = -90

		else:
			current_animation = "Axe_Down"
			$ViewArea.rotation_degrees = 90

	else:

		if player_direction.x < 0:
			current_animation = "Axe_Left"
			$ViewArea.rotation_degrees = 180

		else:
			current_animation = "Axe_Right"
			$ViewArea.rotation_degrees = 0

func _on_Sprite_animation_finished():
	if $Sprite.animation.begins_with("Axe"):
		downtime_timer = downtime_after_attack
		isAttacking = false

#Wander around in search of the player
func random_motion():
	return Vector2(rand_range(-1,1), rand_range(-1,1)).normalized() * movement_speed

#Go straight toward the player's position
func attack_motion():
	isAttacking = true
	return (player_character.position - self.position).normalized() * attack_speed

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

	#if player is spotted, attack them
	if !isAttacking:
		for body in $ViewArea.get_overlapping_bodies():
			if body.name == "PlayerCharacter":
				motion = attack_motion()
				break

	#Rotate toward heading
	if !$Sprite.animation.begins_with("Axe"):
		if abs(motion.y) > abs(motion.x):
	
			if motion.y < 0:
				current_animation = "Up"
				$ViewArea.rotation_degrees = -90
	
			else:
				current_animation = "Down"
				$ViewArea.rotation_degrees = 90
	
		else:
	
			if motion.x < 0:
				current_animation = "Left"
				$ViewArea.rotation_degrees = 180
	
			else:
				current_animation = "Right"
				$ViewArea.rotation_degrees = 0


	$Sprite.play(current_animation)
	#Perform current motion and, if collision occurs stop motion, engage downtime
	if move_and_collide(motion * delta) != null:
		motion = Vector2()
