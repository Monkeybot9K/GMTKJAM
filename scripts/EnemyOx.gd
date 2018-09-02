extends KinematicBody2D

onready var player_character = get_parent().get_node("PlayerCharacter")

export var downtime_after_attack = 0.5
export var movement_speed = 50
export var attack_speed = 180


var isActive = false
var isAttacking = false
var motion = Vector2()
var downtime_timer = 0

var current_animation_index = 1
var animations = ["Up","Down","Left","Right","Axe_Up","Axe_Down","Axe_Left","Axe_Right"]

#If player is spotted, Activate the enemy
func _on_ViewArea_body_entered(body):
	for body in $ViewArea.get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			isActive = true

#If player is lost, go back to chasing
func _on_ViewArea_body_exited(body):
	for body in $ViewArea.get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			#If attacking, stop
			isAttacking = false
			if current_animation_index > 4:
				current_animation_index -= 4
			motion = chase_motion()

#If player is in range and in view, attack
func _on_AttackRange_body_entered(body):
	if !isAttacking:
		return

	motion = Vector2()
	var player_direction = (player_character.position - position).normalized()
	
	if abs(player_direction.y) > abs(player_direction.x):

		if player_direction.y < 0:
			current_animation_index = 4
			$ViewArea.rotation_degrees = -90

		else:
			current_animation_index = 5
			$ViewArea.rotation_degrees = 90

	else:

		if player_direction.x < 0:
			current_animation_index = 6
			$ViewArea.rotation_degrees = 180

		else:
			current_animation_index = 7
			$ViewArea.rotation_degrees = 0

func _on_Sprite_animation_finished():
	if current_animation_index >= 4:
		downtime_timer = downtime_after_attack
		current_animation_index -= 4
		isAttacking = false

#Walk toward player
func chase_motion():
	return (player_character.position - self.position).normalized() * movement_speed

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
		#If no longer in downtime, start moving toward a random one
		motion = chase_motion()

	#if player is in view, continue to attack them
	for body in $ViewArea.get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			motion = attack_motion()
			break

	#Rotate toward heading
	if current_animation_index < 4:
		if abs(motion.y) > abs(motion.x):
	
			if motion.y < 0:
				current_animation_index = 0
				$ViewArea.rotation_degrees = -90
	
			else:
				current_animation_index = 1
				$ViewArea.rotation_degrees = 90
	
		else:
	
			if motion.x < 0:
				current_animation_index = 2
				$ViewArea.rotation_degrees = 180
	
			else:
				current_animation_index = 3
				$ViewArea.rotation_degrees = 0


	$Sprite.play(animations[current_animation_index]) 
	#Perform current motion and, if collision occurs stop motion, engage downtime
	if move_and_collide(motion * delta) != null:
		motion = Vector2()
