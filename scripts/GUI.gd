extends MarginContainer

func _ready():
	GameState.connect("update_gui", self, "update")
	update()
	
func update():
	$HBoxContainer/Number.text = str(GameState.lives)
	