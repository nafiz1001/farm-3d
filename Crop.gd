class_name Crop extends Node3D

@export_group("Crop Property")
@export var canonical_name: String
@export var time_to_evolve: float = 5
@export var evolution: PackedScene

@export_group("Metadata For Soil")
@export var position_on_soil: Vector3 = Vector3.ZERO
@export var scale_on_soil: Vector3 = Vector3.ZERO

var container: Soil
var evolution_time_elapsed: float = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if evolution:
		if hydrated():
			evolution_time_elapsed += delta
			print(evolution_time_elapsed)
		if evolution_time_elapsed >= time_to_evolve:
			evolve()

func evolve():
	container.crop = evolution.instantiate()

func on_hydration(hydrated: bool):
	pass
func hydrate():
	container.hydrate()
func hydrated():
	return container.hydrated()

func get_interaction_area() -> Area3D:
	return container.find_child("InteractionArea")
