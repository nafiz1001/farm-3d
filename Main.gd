extends Node

@export var player: Node

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_camera_click(result: Dictionary) -> void:
	var node = result.collider.get_parent()
	print("%s!" % node.name)
	if node.is_in_group("crop"):
		player.autopilot_on(node.get_parent())