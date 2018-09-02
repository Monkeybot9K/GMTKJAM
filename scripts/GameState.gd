extends Node

var lives = 3

signal update_gui
signal damage_taken
signal open_portal

func OpenPortal():
	emit_signal("open_portal")

func HitCharacter(damage, direction):
	lives = max(lives - damage, 0)
	emit_signal("update_gui")
	emit_signal("damage_taken", [direction])