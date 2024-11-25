extends CharacterBody3D

@export var speed = 100

func _input(event):
	# TODO: move this logic into _physics_process()
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT :
			# https://godotforums.org/d/33479-godot-4-raycasting-to-get-mouse-position-in-3d/3
			var cam = $Camera
			var ray_start = cam.project_ray_origin(event.position)
			var ray_dir = cam.project_ray_normal(event.position)
			var ray_end = ray_start + ray_dir * 100

			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)

			var result = space_state.intersect_ray(query)
			if result:
				var dot = $Dot.duplicate()
				print("%s\t%s\t%s\t%s" % [event.position, ray_start, result.collider.get_path(), result.position])
				dot.position = result.position
				var parent = get_parent()
				parent.add_child(dot)
			else:
				print("No collision")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
		$Pivot.look_at(self.position + Vector3(target_velocity.z, 0, -target_velocity.x))
	else:
		self.velocity = Vector3.ZERO
	move_and_slide()
