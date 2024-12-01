class_name SoilHydration extends RefCounted

var hydration: float = 0
var dehydration_time: float = 1

func process(delta: float):
	if hydration > 0:
		hydration -= delta * 1/dehydration_time
		if hydration <= 0:
			hydration = 0

func hydrate() -> void:
	hydration = 1

func hydrated():
	return hydration > 0
