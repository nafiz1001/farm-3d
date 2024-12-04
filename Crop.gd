class_name Crop extends Node3D

@export var position_on_soil: Vector3 = Vector3.ZERO
@export var scale_on_soil: Vector3 = Vector3.ZERO
@export var canonical_name: String

var container: Soil

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func on_hydration(hydrated: bool):
	$Label.text = "Hydrated: %s" % hydrated

func hydrate():
	container.hydrate()
func hydrated():
	return container.hydrated()
func get_interaction_area() -> Area3D:
	return container.find_child("InteractionArea")
