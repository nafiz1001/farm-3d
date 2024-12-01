extends Node3D

@export var zoom_scale: float = 1

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			self.position -= self.basis.z * zoom_scale
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			self.position += self.basis.z * zoom_scale


func _ready() -> void:
	look_at(get_parent().global_position)

func _process(_delta: float) -> void:
	pass
