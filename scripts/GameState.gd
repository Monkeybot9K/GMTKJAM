extends Node

var Lives = 3

signal update_gui

func SetLives(lives):
	self.Lives = lives
	emit_signal("update_gui")