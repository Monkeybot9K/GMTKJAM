extends Node

var Lives = 3

signal update_gui
signal damage_taken

func SetLives(lives):
	if self.Lives > lives:
		emit_signal("damage_taken")
	self.Lives = lives
	emit_signal("update_gui")