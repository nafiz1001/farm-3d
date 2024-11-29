class_name Crop extends Node3D

@export var position_on_soil: Vector3
@export var scale_on_soil: Vector3

var hydration_amount: float = 0.0

func _ready() -> void:
	pass

func hydrate_process(delta: float):
	self.hydration_amount += delta
	$Label.text = "%.2f%% Hydrated" % self.hydration_amount

func get_soil() -> Node:
	return get_parent()

func set_interation_area_visible(visible: bool):
	self.get_soil().find_child("InteractionArea").set_visible(visible)

func interaction_area_overlap(area: Area3D) -> bool:
	return self.get_soil().find_child("InteractionArea").overlaps_area(area)
