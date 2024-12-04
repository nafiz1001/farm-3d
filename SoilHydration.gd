class_name SoilHydration extends RefCounted

signal on_hydration(hydrated: bool)

var hydration: float = 0
var dehydration_time: float = 1

func process(delta: float):
	if hydration > 0:
		hydration -= delta * 1/dehydration_time
		if hydration <= 0:
			hydration = 0
			on_hydration.emit(false)

func hydrate() -> void:
	hydration = 1
	on_hydration.emit(true)

func hydrated():
	return hydration > 0
