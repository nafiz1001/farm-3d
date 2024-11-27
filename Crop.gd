extends Node3D

var hydrate = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if hydrate:
		$CropHydration.hydration_amount += delta

func _on_interaction_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		hydrate = true

func _on_interaction_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		hydrate = false 
