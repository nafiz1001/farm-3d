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

var hydration: SoilHydration = SoilHydration.new()

func _ready() -> void:
	if crop_:
		crop = crop_
func _process(delta: float) -> void:
	hydration.process(delta)

func hydrate() -> void:
	return hydration.hydrate()
func hydrated():
	return hydration.hydrated()

func get_interaction_area() -> Area3D:
	return $InteractionArea
