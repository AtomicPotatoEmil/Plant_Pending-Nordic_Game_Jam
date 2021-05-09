extends Node2D

onready var anim = $Anim
onready var phase2timer = $Timers/Phase2Timer
onready var phase3timer = $Timers/Phase3Timer
signal fully_grown

var planted_plant = null

signal potato
signal watermelon
signal cabbage
signal carrot
signal cauliflower
signal audrey

enum plants_to_be_planted {
	POTATO,
	WATERMELON,
	CABBAGE,
	CARROT,
	CAULIFLOWER,
	AUDREY
}

func _ready():
	anim.play("seed")
	match planted_plant:
		plants_to_be_planted.POTATO:
			emit_signal("potato")
		plants_to_be_planted.WATERMELON:
			emit_signal("watermelon")
		plants_to_be_planted.CABBAGE:
			emit_signal("cabbage")
		plants_to_be_planted.CARROT:
			emit_signal("carrot")
		plants_to_be_planted.CAULIFLOWER:
			emit_signal("cauliflower")
		plants_to_be_planted.AUDREY:
			emit_signal("audrey")
	print(planted_plant)


func _on_Phase1Timer_timeout():
	anim.play("phase1")
	phase2timer.start()
	pass # Replace with function body.


func _on_Phase2Timer_timeout():
	anim.play("phase2")
	phase3timer.start()
	pass # Replace with function body.


func _on_Phase3Timer_timeout():
	anim.play("phase3")
	emit_signal("fully_grown")
	pass # Replace with function body.
