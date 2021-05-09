extends Position2D

onready var anim = $Anim
var pos = null

func _ready():
	anim.play("water")


func _on_Anim_animation_finished():
	if anim.animation == "water":
		queue_free()
	pass # Replace with function body.
