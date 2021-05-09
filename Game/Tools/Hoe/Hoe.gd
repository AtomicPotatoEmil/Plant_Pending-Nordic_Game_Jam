extends Position2D

onready var anim = $Anim

func _ready():
	anim.play("Anim")


func _on_Anim_animation_finished(anim_name):
	if anim_name == "Anim":
		queue_free()
	pass # Replace with function body.
