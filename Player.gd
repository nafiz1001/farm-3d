extends CharacterBody3D

@export var speed = 100

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var target_velocity = Vector3(
		Input.get_axis("forward", "backward"),
		0,
		Input.get_axis("right", "left")
	)
	if target_velocity.length_squared() > 0:
		target_velocity = target_velocity.normalized()
		self.velocity = target_velocity * speed * delta
		self.horizontal_look_at(self.position + Vector3(target_velocity.x, 0, target_velocity.z))
	else:
		self.velocity = Vector3.ZERO
	move_and_slide()

func _on_camera_click(result: Dictionary) -> void:
	var node = result.collider
	if node.is_in_group("crop"):
		node = node.get_parent()
		print("%s!" % node.name)
		var pos = node.global_position
		self.horizontal_look_at(pos)

func horizontal_look_at(target: Vector3):
	$Pivot.look_at(target, self.up_direction, true)
	$Pivot.rotation.x = 0
	$Pivot.rotation.z = 0
