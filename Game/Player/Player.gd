extends KinematicBody2D

var SPEED = 325
var ACCELERATION = 2000
var velocity = Vector2.ZERO
onready var anim = $AnimPlayer
onready var anim_cross = $Cross/CrossSprite/CrossAnim
onready var tool_position = $Tool
onready var muddy_steps_sound = $MuddySteps

const wateringcan = preload("res://Tools/WateringCan/WateringCan.tscn")
const hoe = preload("res://Tools/Hoe/Hoe.tscn")

func _ready():
	anim_cross.play("anim")

func _physics_process(delta):
	get_input(delta)
	look_at(get_global_mouse_position())
	velocity = move_and_slide(velocity)

func get_input(dt):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		velocity.x += 1 * dt
	if Input.is_action_pressed("left"):
		velocity.x -= 1 * dt
	if Input.is_action_pressed("down"):
		velocity.y += 1 * dt
	if Input.is_action_pressed("up"):
		velocity.y -= 1 * dt
	
	if velocity == Vector2.ZERO:
		anim.stop()
		muddy_steps_sound.stop()
	else:
		anim.play("anim")
		if muddy_steps_sound.playing == false:
			muddy_steps_sound.play()
	
	if Input.is_action_just_pressed("water") and tool_position.get_child_count() == 0:
		spawn_wateringcan()
	if Input.is_action_just_pressed("hoe") and tool_position.get_child_count() == 0:
		spawn_hoe()
		
	velocity = velocity.normalized() * SPEED

func spawn_wateringcan():
	var tool_instance = wateringcan.instance()
	tool_position.add_child(tool_instance)

func spawn_hoe():
	var tool_intance = hoe.instance()
	tool_position.add_child(tool_intance)
