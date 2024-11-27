extends Node3D

var _hydration_amount: float = 0
var hydration_amount: float:
	get:
		return _hydration_amount
	set(amount):
		_hydration_amount = amount
		$Label.text = "%.2f%% Hydrated" % amount

func _ready() -> void:
	self.hydration_amount = 0

func _process(delta: float) -> void:
	pass
