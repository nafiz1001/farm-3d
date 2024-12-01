class_name Character extends CharacterBody3D

@export var speed: float = 1

var velocity_direction := Vector3.ZERO

var human_controller: HumanController = HumanController.new()

func _ready() -> void:
	human_controller.ready(self)
func _process(_delta: float) -> void:
	get_controller().process(self)
func _physics_process(_delta: float) -> void:
	velocity = velocity_direction * speed
	move_and_slide()
func _input(event: InputEvent) -> void:
	get_controller().input(self, event)

func move_direction(displacement: Vector3):
	displacement.y = 0
	velocity_direction = displacement.normalized()
	horizontal_look_at(global_position + displacement)
func horizontal_look_at(target: Vector3):
	if target == global_position:
		return
	$Pivot.look_at(target, up_direction, true)
	$Pivot.rotation.x = 0
	$Pivot.rotation.z = 0

func interact(target):
	var target_area = target.get_interaction_area()
	if $InteractionArea.overlaps_area(target_area):
		target.hydrate()
		target_area.outline = true
		await get_tree().create_timer(0.1).timeout
		target_area.outline = false

func get_controller() -> Controller:
	return human_controller
