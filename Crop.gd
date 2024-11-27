extends Node3D

var hydrate = false
var hydration_amount: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if hydrate:
		self.hydration_amount += delta
	$Label.text = "%.2f%% Hydrated" % self.hydration_amount

func hydrate_start():
	self.hydrate = true
func hydrate_stop():
	self.hydrate = false
