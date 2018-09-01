extends KinematicBody2D

var movement_speed = 200

var motion = Vector2()
var currentAnimation = "Idle"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	motion = Vector2()
	currentAnimation = "Idle"
	
	handle_input()

	$Sprite.play(currentAnimation)
	move_and_slide(motion)
	

#Defend or move according to user input
func handle_input():
	if Input.is_action_pressed("Defend"):
		currentAnimation = "Defend_Right"
		if Input.is_action_pressed("ui_left"):
			currentAnimation = "Defend_Left"
		elif Input.is_action_pressed("ui_up"):
			currentAnimation = "Defend_Up"
		elif Input.is_action_pressed("ui_down"):
			currentAnimation = "Defend_Down"
	elif Input.is_action_pressed("Defend_Left"):
		currentAnimation = "Defend_Left"
	elif Input.is_action_pressed("Defend_Right"):
		currentAnimation = "Defend_Right"
	elif Input.is_action_pressed("Defend_Up"):
		currentAnimation = "Defend_Up"
	elif Input.is_action_pressed("Defend_Down"):
		currentAnimation = "Defend_Down"
	else:
		if Input.is_action_pressed("ui_left"):
			motion.x = -movement_speed
			currentAnimation = "Run"
			$Sprite.flip_h = true
		elif Input.is_action_pressed("ui_right"):
			motion.x = movement_speed
			currentAnimation = "Run"
			$Sprite.flip_h = false
	
		if Input.is_action_pressed("ui_up"):
			motion.y = -movement_speed
			currentAnimation = "Run"
		elif Input.is_action_pressed("ui_down"):
			motion.y = movement_speed
			currentAnimation = "Run"