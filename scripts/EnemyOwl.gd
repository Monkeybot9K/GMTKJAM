extends KinematicBody2D

onready var player_character = get_parent().get_node("PlayerCharacter")

var isActive = false
#If player is spotted, Activate the enemy
func _on_Area2D_body_entered(body):    
    for body in $Area2D.get_overlapping_bodies():
        isActive = body.name == "PlayerCharacter"

func _on_Area2D_body_exited(body):
	if $Area2D.get_overlapping_bodies().has(player_character):
		isActive = false

export var initial_position = 2
export var side_change_timeout = 3
export var shoot_cooldown = 2

const dirs = [Vector2(0,1), Vector2(-1,0), Vector2(0,-1), Vector2(1,0)]

var side_change_timer = 0
var shoot_timer = 0
var current_side = 0

signal shoot

func idle_movement():
	current_side += 1
	current_side %= 4
	$Area2D.rotation_degrees = 90 * current_side
	$Sprite.frame = current_side
	side_change_timer = side_change_timeout
	
func shoot():
	emit_signal("shoot", [ dirs[current_side], $Position2D.get_global_transform().get_origin() ])
	shoot_timer = shoot_cooldown
	
func _ready():
	current_side = initial_position
	$Area2D.rotation_degrees = 90 * current_side
	$Sprite.frame = current_side
	side_change_timer = side_change_timeout

func _process(delta):
	if isActive:
		if shoot_timer > 0:
			shoot_timer -= delta
		else:
			shoot()
	else:
		if side_change_timer > 0:
			side_change_timer -= delta
		else:
			idle_movement()
			shoot_timer = 0

