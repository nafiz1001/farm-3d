class_name AutopilotController extends Controller

signal on_interrupted
signal on_finish

var target_node: Node3D
var target_area: Area3D
var displacement_epsilon: float = 0.1

const interruptible_actions := [
	"left", "right",
	"forward", "backward"
]

func _init(target_node: Node3D, target_area: Area3D = null) -> void:
	self.target_node = target_node
	self.target_area = target_area

func ready(character: Character) -> void:
	var character_area: Area3D = character.find_child("InteractionArea")
	if target_area and target_area.overlaps_area(character_area):
		finish()
func process(character: Character) -> void:
	var displacement := target_node.global_position - character.global_position
	displacement.y = 0
	if displacement.length_squared() < displacement_epsilon**2:
		finish()
	else:
		character.move_direction(displacement)
func input(event: InputEvent) -> void:
	for action in interruptible_actions:
		if event.is_action_pressed(action):
			interrupt()

func on_interaction_area_area_entered(area: Area3D) -> void:
	if area == target_area:
		finish()

func finish():
	on_finish.emit()
func interrupt():
	on_interrupted.emit()
