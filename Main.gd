extends Node

@export var character: Character

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_camera_click(result: Dictionary) -> void:
	var node = result.collider.get_parent()
	print("%s!" % node.name)
	if node.is_in_group("crop"):
		character.autopilot_on(node.soil)
	elif node.is_in_group("soil"):
		character.autopilot_on(node)
