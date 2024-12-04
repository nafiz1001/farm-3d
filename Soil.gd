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
			crop.position = crop.position_on_soil
			crop.scale = crop.scale_on_soil
			crop.container = self
			hydration.on_hydration.connect(crop.on_hydration)
			crop.on_hydration(hydrated())
			add_child(crop)

var hydration: SoilHydration = SoilHydration.new()

func _ready() -> void:
	if crop_:
		crop = crop_
func _process(delta: float) -> void:
	hydration.process(delta)

func hydrate() -> void:
	hydration.hydrate()
func hydrated():
	return hydration.hydrated()

func get_interaction_area() -> Area3D:
	return $InteractionArea
