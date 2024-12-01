extends Node

@export var character: Character

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_camera_click(result: Dictionary) -> void:
	var node: Node = result.collider
	if node.get_parent():
		node = node.get_parent()
	if node.is_in_group("crop") or node.is_in_group("soil"):
		var area = node.get_interaction_area()
		character.interact(node)
