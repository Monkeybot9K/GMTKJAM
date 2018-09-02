extends Node

var Lives = 3

signal update_gui

func SetLives(lives):
	self.Lives = lives
	emit_signal("update_gui")

func HitCharacter(damage):
	Lives = max(Lives - damage, 0)
	emit_signal("update_gui")