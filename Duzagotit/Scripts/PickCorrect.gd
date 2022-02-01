extends Node2D

signal correct
signal wrong

var correct = false;

func _on_TB0_pressed():
	correct = true
	emit_signal("correct")

func _on_TB1_pressed():
	emit_signal("wrong")

