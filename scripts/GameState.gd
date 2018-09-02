extends Node

var lives = 3

signal update_gui
signal damage_taken

func HitCharacter(damage):
	lives = max(lives - damage, 0)
	emit_signal("update_gui")
	emit_signal("damage_taken")