extends KinematicBody2D

onready var player_character = get_parent().get_node("PlayerCharacter")

export var downtime_after_attack = 5
export var movement_speed = 50
export var ramming_speed = 400

var isActive = false
var motion = Vector2()
var downtime_timer = 0

#Go straight toward the player's position
func ramming_motion():
	return (player_character.position - self.position).normalized() * ramming_speed
	
#Wander around in search of the player
func random_motion():
	randomize()
	var x = floor(rand_range(-1,1))
	var y = floor(rand_range(-1,1))
	return Vector2(x,y).normalized() * movement_speed

func _physics_process(delta):
	#If inactive, do nothing
	if isActive == false:
		return
	
	#Update downtime if needed
	if downtime_timer > 0:
		downtime_timer -= delta
	else:
		#If not moving and ready, start moving toward a random heading
		if motion.length() == 0:
			motion = random_motion()
			
	for body in $Area2D.get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			isActive = true
			motion = ramming_motion()
			break
	
	#Rotate toward heading
	look_at(motion)
	
	#Perform current motion and, if collision occurs, engage downtime
	if move_and_collide(motion * delta) != null:
		downtime_timer = downtime_after_attack
		motion = Vector2()

func _on_Area2D_body_entered(body):
	
	#If player is spotted, Activate
	for body in $Area2D.get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			isActive = true
