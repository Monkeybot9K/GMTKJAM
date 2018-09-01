extends KinematicBody2D

var speed = 2
export var direction = Vector2(0, 0)

func _physics_process(delta):
	move_and_collide(direction * speed)