extends Node2D

signal correct
signal wrong

var correct = false;
var pressed_once = false

func _on_TB0_pressed():
	if !pressed_once:
		pressed_once = true
		correct = true
		emit_signal("correct")

func _on_TB1_pressed():
	if !pressed_once:
		pressed_once = true
		emit_signal("wrong")

