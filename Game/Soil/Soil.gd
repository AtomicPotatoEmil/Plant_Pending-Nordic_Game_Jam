extends Area2D

onready var anim = $Anim
onready var anim_color = $AnimColor
onready var plant_container = $PlantContainer
onready var thirsy_timer = $ThirstyTimer
onready var dying_timer = $DyingTimer
onready var ghost_flower = preload("res://Plants/GhostPlant/GhostFlower.tscn")

onready var plants = [preload("res://Plants/Potato/Potato.tscn"), preload("res://Plants/Watermelon/Watermelon.tscn"),
					  preload("res://Plants/Cabbage/Cabbage.tscn"), preload("res://Plants/Carrot/Carrot.tscn"),
					  preload("res://Plants/Cauliflower/Cauliflower.tscn"), preload("res://Plants/Audrey/Audrey.tscn")]

onready var seed_sound = $SeedPlantedSound

var has_seed = false
var selected = false

var plant_is_grown = false

signal POTATO
signal WATERMELON
signal CABBAGE
signal CARROT
signal CAULIFLOWER
signal AUDREY

enum plant_sorts {
	POTATO,
	WATERMELON,
	CABBAGE,
	CARROT,
	CAULIFLOWER,
	AUDREY
}

func _ready():
	anim.play("default")
	pass

func _physics_process(delta):
	if plant_container.get_child_count() > 0:
		has_seed = true
	else:
		has_seed = false
	
	if selected and plant_container.get_child_count() == 0:
		if Input.is_action_just_pressed("left_click"):
			randomize()
			#var random_number = int(randi() % plants.size())
			#var plant_instance = plants[random_number].instance()
			#plant_container.add_child(plant_instance)
			self.thirsy_timer.start()
			seed_sound.play()
			var random_plant = int(plant_sorts.values()[randi() % plant_sorts.size()])
			match random_plant:
				plant_sorts.POTATO:
					var plant_instance = plants[0].instance()
					plant_instance.planted_plant = plant_instance.plants_to_be_planted.POTATO
					plant_container.add_child(plant_instance)
					self.thirsy_timer.start()
				plant_sorts.WATERMELON:
					var plant_instance = plants[1].instance()
					plant_instance.planted_plant = plant_instance.plants_to_be_planted.WATERMELON
					plant_container.add_child(plant_instance)
					self.thirsy_timer.start()
				plant_sorts.CABBAGE:
					var plant_instance = plants[2].instance()
					plant_instance.planted_plant = plant_instance.plants_to_be_planted.CABBAGE
					plant_container.add_child(plant_instance)
					self.thirsy_timer.start()
				plant_sorts.CARROT:
					var plant_instance = plants[3].instance()
					plant_instance.planted_plant = plant_instance.plants_to_be_planted.CARROT
					plant_container.add_child(plant_instance)
					self.thirsy_timer.start()
				plant_sorts.CAULIFLOWER:
					var plant_instance = plants[4].instance()
					plant_instance.planted_plant = plant_instance.plants_to_be_planted.CAULIFLOWER
					plant_container.add_child(plant_instance)
					self.thirsy_timer.start()
				plant_sorts.AUDREY:
					var plant_instance = plants[5].instance()
					plant_instance.planted_plant = plant_instance.plants_to_be_planted.AUDREY
					plant_container.add_child(plant_instance)
					self.thirsy_timer.stop()
					self.dying_timer.stop()
			for child in plant_container.get_children():
				child.connect("fully_grown", self, "plant_status_change")
				pass
	
	if selected:
		anim.play("selected")
	else:
		anim.play("default")

func _on_Soil_area_entered(area):
	if area.is_in_group("select") and not has_seed:
		selected = true
	if area.is_in_group("hoe"):
		self.thirsy_timer.stop()
		self.dying_timer.stop()
		anim_color.play("default")
		for child in plant_container.get_children():
			child.queue_free()
		if plant_is_grown:
			for child in plant_container.get_children():
				match child.planted_plant:
					child.plants_to_be_planted.POTATO:
						emit_signal("POTATO")
					child.plants_to_be_planted.WATERMELON:
						emit_signal("WATERMELON")
					child.plants_to_be_planted.CABBAGE:
						emit_signal("CABBAGE")
					child.plants_to_be_planted.CARROT:
						emit_signal("CARROT")
					child.plants_to_be_planted.CAULIFLOWER:
						emit_signal("CAULIFLOWER")
					child.plants_to_be_planted.AUDREY:
						emit_signal("AUDREY")
		plant_is_grown = false

	if area.is_in_group("water"):
		self.thirsy_timer.stop()
		self.thirsy_timer.start()
		self.dying_timer.stop()
		anim_color.play("default")
	pass # Replace with function body.


func _on_Soil_area_exited(area):
	if area.is_in_group("select"):
		selected = false
	pass # Replace with function body.


func _on_ThirstyTimer_timeout():
	self.dying_timer.start()
	anim_color.play("thirsty")
	pass # Replace with function body.


func _on_DyingTimer_timeout():
	for child in plant_container.get_children():
		child.queue_free()
	anim_color.play("default")
	var ghost_instance = ghost_flower.instance()
	self.add_child(ghost_instance)
	pass # Replace with function body.

func plant_status_change():
	print(plant_is_grown)
	plant_is_grown = true
	print(plant_is_grown)
