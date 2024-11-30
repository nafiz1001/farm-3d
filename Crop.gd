class_name Crop extends Node3D

var soil: Soil

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	$Label.text = "Hydrated: %s" % soil.hydrated()

func hydrate():
	soil.hydrate()

func get_interaction_area() -> Area3D:
	return soil.find_child("InteractionArea")
