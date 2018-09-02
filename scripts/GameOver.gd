extends Control

func _on_RestartButton_pressed():
	get_tree().change_scene("res://levels/Level0.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
