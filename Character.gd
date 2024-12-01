class_name Character extends CharacterBody3D

@export var speed: float = 1

var velocity_direction := Vector3.ZERO

var human_controller: HumanController = HumanController.new()
var autopilot_controller: AutopilotController = null

func _ready() -> void:
	human_controller.ready(self)
func _process(_delta: float) -> void:
	get_controller().process(self)
func _physics_process(_delta: float) -> void:
	velocity = velocity_direction * speed
	move_and_slide()
func _input(event: InputEvent) -> void:
	get_controller().process(self)

func autopilot_on(node: Node3D):
	node.get_interaction_area().outline = true
	autopilot_controller = AutopilotController.new(node, node.find_child("InteractionArea"))
	autopilot_controller.on_finish.connect(autopilot_on_finish)
	autopilot_controller.on_interrupted.connect(autopilot_on_interrupted)
	autopilot_controller.ready(self)
func autopilot_on_finish():
	var node = autopilot_controller.target_node
	node.get_interaction_area().outline = false
	autopilot_controller = null
	node.hydrate()
func autopilot_on_interrupted():
	var node = autopilot_controller.target_node
	node.get_interaction_area().outline = false
	autopilot_controller = null

func _on_interaction_area_area_entered(area: Area3D) -> void:
	if autopilot_controller:
		autopilot_controller.on_interaction_area_area_entered(area)

func move_direction(displacement: Vector3):
	displacement.y = 0
	velocity_direction = displacement.normalized()
	horizontal_look_at(global_position + displacement)
func horizontal_look_at(target: Vector3):
	$Pivot.look_at(target, up_direction, true)
	$Pivot.rotation.x = 0
	$Pivot.rotation.z = 0

func get_controller() -> Controller:
	if autopilot_controller:
		return autopilot_controller
	else:
		return human_controller
