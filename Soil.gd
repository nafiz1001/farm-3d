class_name Soil extends Node3D

@export var crop_: Crop
var crop: Crop:
	get:
		return crop_
	set(value):
		if crop:
			remove_child(crop)
		crop_ = value
		if crop:
			crop.position = crop.get_meta("position_on_soil")
			crop.scale = crop.get_meta("scale_on_soil")
			crop.soil = self
			add_child(crop)

@export var dehydration_time: float = 1
var hydration: float = 0

func _ready() -> void:
	if crop_:
		crop = crop_
func _process(delta: float) -> void:
	if hydration > 0:
		hydration -= delta * 1/dehydration_time
		if hydration <= 0:
			hydration = 0

func hydrate() -> void:
	hydration = 1
func hydrated():
	return hydration > 0

func get_interaction_area() -> Area3D:
	return $InteractionArea
