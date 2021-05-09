extends Sprite

onready var anim = $Anim

func _ready():
	anim.play("ghostly_shit")
	pass


func _on_Anim_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.
