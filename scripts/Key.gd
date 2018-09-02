extends Area2D

signal key_picked

func _physics_process(delta):
	for body in self.get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			GameState.OpenPortal()
			emit_signal("key_picked")