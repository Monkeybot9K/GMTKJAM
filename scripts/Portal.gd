extends Area2D

export(String, FILE, "*.tscn") var target

export var locked = false

func _ready():
	toggleLocked(locked)

func _physics_process(delta):
	if target == null: return
	for body in get_overlapping_bodies():
		if body.name == "PlayerCharacter":
			get_tree().change_scene(target)

func toggleLocked(locked):
	#Toggle Portal accordingly
	$CollisionShape2D.disabled = locked
	$Sprite.frame = 0 if locked else 1