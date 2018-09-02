extends KinematicBody2D

var movement_speed = 200
var damaged_impulse = 300
var damaged_cooldown = .25

var motion = Vector2()
var currentAnimation = "Idle"
var defending = false
var damaged = false
var damaged_dir = Vector2()
var damaged_timer = 0

func _ready():
	GameState.connect("damage_taken", self, "handle_damage_taken")

func handle_damage_taken(args):
	$Sprite.modulate = Color(.85, 0, 0)
	damaged_timer = damaged_cooldown
	damaged_dir = args[0]
	damaged = true
	
func _process(delta):
	if damaged:
		if damaged_timer > 0:
			damaged_timer -= delta
		else:
			$Sprite.modulate = Color(1, 1, 1)
			damaged = false 

func _physics_process(delta):
	motion = Vector2()
	currentAnimation = "Idle"
	if damaged:
		motion = damaged_dir * damaged_impulse
	else:
		handle_input()

	$Shield/CollisionShape2D.disabled = !defending
	$Sprite.play(currentAnimation)
	
	move_and_slide(motion)
	
#Defend or move according to user input
func handle_input():
	#Make sure sprite is not mirrored by default
	$Sprite.flip_h = false
	#Set to defending by default
	defending = true
	
	if Input.is_action_pressed("Defend"):
		if Input.is_action_pressed("ui_left"):
			currentAnimation = "Defend_Left"
			$Shield.rotation_degrees = 180

		elif Input.is_action_pressed("ui_right"):
			currentAnimation = "Defend_Right"
			$Shield.rotation_degrees = 0

		elif Input.is_action_pressed("ui_up"):
			currentAnimation = "Defend_Up"
			$Shield.rotation_degrees = -90

		elif Input.is_action_pressed("ui_down"):
			currentAnimation = "Defend_Down"
			$Shield.rotation_degrees = 90

		else:
			#Not defending
			defending = false

	elif Input.is_action_pressed("Defend_Left"):
		currentAnimation = "Defend_Left"
		$Shield.rotation_degrees = 180

	elif Input.is_action_pressed("Defend_Right"):
		currentAnimation = "Defend_Right"
		$Shield.rotation_degrees = 0

	elif Input.is_action_pressed("Defend_Up"):
		currentAnimation = "Defend_Up"
		$Shield.rotation_degrees = -90

	elif Input.is_action_pressed("Defend_Down"):
		currentAnimation = "Defend_Down"
		$Shield.rotation_degrees = 90

	else:
		#Not Defending
		defending = false
		if Input.is_action_pressed("ui_left"):
			motion.x = -movement_speed
			currentAnimation = "Run"
			$Sprite.flip_h = true

		elif Input.is_action_pressed("ui_right"):
			motion.x = movement_speed
			currentAnimation = "Run"

		if Input.is_action_pressed("ui_up"):
			motion.y = -movement_speed
			currentAnimation = "Run"

		elif Input.is_action_pressed("ui_down"):
			motion.y = movement_speed
			currentAnimation = "Run"