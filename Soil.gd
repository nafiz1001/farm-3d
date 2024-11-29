extends Node3D

@export var crop_scene: PackedScene
var crop: Crop

var hydrate: bool = false

func _ready() -> void:
	crop = self.crop_scene.instantiate()
	crop.position = crop.position_on_soil
	crop.scale = crop.scale_on_soil
	add_child(crop)

func _process(delta: float) -> void:
	if hydrate:
		crop.hydrate_process(delta)

func hydrate_start():
	self.hydrate = true
func hydrate_stop():
	self.hydrate = false
