extends MarginContainer

func _ready():
	GameState.connect("update_gui", self, "update")
	
	update()
	
func update():
	print("update_gui")
	$HBoxContainer/Number.text = str(GameState.lives)
	