extends KinematicBody2D

var speed = 2
var direction = Vector2(0, 0)
var dead = false

func _physics_process(delta):
	move_and_collide(direction * speed)