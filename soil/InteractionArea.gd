extends Area3D

@export var outline_: bool = false
var outline:
	get:
		return $Outline.visible
	set(value):
		$Outline.visible = value

func _ready() -> void:
	self.outline = outline_
