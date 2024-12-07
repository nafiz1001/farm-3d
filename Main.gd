extends Node

@export var character: Character

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_camera_click(result: Dictionary) -> void:
	var root_node = get_tree().current_scene
	var node: Node = result.collider
	if node.get_parent() != root_node:
		node = node.get_parent()
	print(node)
	if node.is_in_group("crop") or node.is_in_group("soil"):
		character.interact(node)
		var target_area = node.get_interaction_area()
		target_area.outline = true
		await get_tree().create_timer(0.1).timeout
		target_area.outline = false
	else:
		var soil := preload("res://soil/soil.tscn").instantiate()
		soil.position = result.position
		soil.crop = preload("res://cabbage/cabbage_1.tscn").instantiate()
		root_node.add_child(soil)
