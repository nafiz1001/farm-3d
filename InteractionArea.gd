extends Area3D

@export var outline_: bool = false
var outline:
	get:
		return outline_
	set(value):
		outline_ = value
		$Outline.set_visible(outline)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Outline.set_visible(outline)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
