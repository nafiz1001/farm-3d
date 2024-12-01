class_name HumanController extends Controller

func process(character: Character) -> void:
	var x_input := Input.get_axis("forward", "backward")
	var z_input := Input.get_axis("right", "left")
	character.move_direction(Vector3(x_input, 0, z_input))
