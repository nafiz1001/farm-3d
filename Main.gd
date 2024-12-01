extends Node

@export var character: Character

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_camera_click(result: Dictionary) -> void:
	var node: Node = result.collider
	if node.get_parent():
		node = node.get_parent()
	if node.is_in_group("crop") or node.is_in_group("soil"):
		character.interact(node)
