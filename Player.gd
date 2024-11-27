extends CharacterBody3D

@export var speed = 1

var autopilot_target: Node3D = null
var velocity_direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var x_input = Input.get_axis("forward", "backward")
	var z_input = Input.get_axis("right", "left")

	if x_input != 0 or z_input != 0:
		self.autopilot_off()
		velocity_direction = Vector3(x_input, 0, z_input).normalized()
		self.horizontal_look_at(self.position + velocity_direction)
	elif autopilot_target:
		self.autopilot_process()
	else:
		velocity_direction = Vector3.ZERO

func _on_camera_click(result: Dictionary) -> void:
	var node = result.collider
	if node.is_in_group("crop"):
		node = node.get_parent()
		print("%s!" % node.name)
		autopilot_on(node)

func autopilot_on(target: Node3D):
	autopilot_target = target
	autopilot_target.find_child("InteractionArea", false).set_visible(true)
func autopilot_off():
	if autopilot_target:
		autopilot_target.find_child("InteractionArea", false).set_visible(false)
		autopilot_target = null
func autopilot_process():
	var displacement = autopilot_target.global_position - self.global_position
	displacement.y = 0
	velocity_direction = displacement.normalized()
	self.horizontal_look_at(self.position + displacement)

func _on_interaction_area_area_entered(area: Area3D) -> void:
	if self.autopilot_target and area.get_parent() == self.autopilot_target:
		self.autopilot_off()
		velocity_direction = Vector3.ZERO

func horizontal_look_at(target: Vector3):
	$Pivot.look_at(target, self.up_direction, true)
	$Pivot.rotation.x = 0
	$Pivot.rotation.z = 0

func _physics_process(_delta: float) -> void:
	self.velocity = velocity_direction * speed
	move_and_slide()
