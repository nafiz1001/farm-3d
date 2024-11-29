extends Node3D

@export var crop_scene: PackedScene
var crop_node: Node

func _ready() -> void:
	crop_node = self.crop_scene.instantiate()
	var crop_metadata := crop_node.find_child("CropMetadata", false)
	crop_node.position = crop_metadata.position_offset
	crop_node.scale = crop_metadata.scale
	add_child(crop_node)

func _process(delta: float) -> void:
	pass

func hydrate_start():
	crop_node.hydrate_start()
func hydrate_stop():
	crop_node.hydrate_stop()
