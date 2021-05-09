extends Node2D

onready var soil_container = $SoilContainer

var audrey_count = 0

func _ready():
	for child in soil_container.get_children():
		child.connect("AUDREY", self, "audrey_counter")

func audrey_counter():
	audrey_count += 1
	print(audrey_count)
