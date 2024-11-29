extends Node3D

@export var crop_scene: PackedScene
var crop_: Crop
var crop:
	get:
		return crop_
	set(value):
		if crop:
			remove_child(crop)
		crop_ = value
		if crop:
			crop.position = crop.position_on_soil
			crop.scale = crop.scale_on_soil
			add_child(crop)

var hydrate: bool = false

func _ready() -> void:
	self.crop = self.crop_scene.instantiate()

func _process(delta: float) -> void:
	if hydrate:
		crop.hydrate_process(delta)

func hydrate_start():
	self.hydrate = true
func hydrate_stop():
	self.hydrate = false
