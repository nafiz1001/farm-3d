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
		autopilot_target = null
		velocity_direction = Vector3(x_input, 0, z_input).normalized()
		self.horizontal_look_at(self.position + velocity_direction)
	elif autopilot_target:
		var displacement = autopilot_target.global_position - self.position
		displacement.y = 0
		if displacement.length() > 1:
			velocity_direction = displacement.normalized()
			self.horizontal_look_at(autopilot_target.global_position)
		else:
			autopilot_target = null
	else:
		velocity_direction = Vector3.ZERO

func _physics_process(_delta: float) -> void:
	self.velocity = velocity_direction * speed
	move_and_slide()

func _on_camera_click(result: Dictionary) -> void:
	var node = result.collider
	if node.is_in_group("crop"):
		node = node.get_parent()
		print("%s!" % node.name)
		var pos = node.global_position
		self.horizontal_look_at(pos)
		autopilot_target = node

func horizontal_look_at(target: Vector3):
	$Pivot.look_at(target, self.up_direction, true)
	$Pivot.rotation.x = 0
	$Pivot.rotation.z = 0
