extends KinematicBody2D

var movement_speed = 200

var motion = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	motion = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -movement_speed
	elif Input.is_action_pressed("ui_right"):
		motion.x = movement_speed
	
	if Input.is_action_pressed("ui_up"):
		motion.y = -movement_speed
	elif Input.is_action_pressed("ui_down"):
		motion.y = movement_speed

	move_and_slide(motion)