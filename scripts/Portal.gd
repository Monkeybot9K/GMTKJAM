extends Area2D

export(String, FILE, "*.tscn") var target

func _physics_process(delta):
	if target == null: return
	for body in get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			get_tree().change_scene(target)