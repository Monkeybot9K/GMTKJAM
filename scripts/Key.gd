extends StaticBody2D

signal key_picked

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			emit_signal("key_picked")