extends Node

export (PackedScene) var House1

var house

# Called when the node enters the scene tree for the first time.
func _ready():
	House1()


func House1():
	house = House1.instance()
