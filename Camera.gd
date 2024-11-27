extends Camera3D

signal click(result: Dictionary)

@export var camera_target: Node3D

const noclick_position = Vector2(-1, -1)
var click_position: Vector2 = noclick_position
var click_result = null

func _ready() -> void:
	self.global_transform = camera_target.global_transform

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				click_position = event.position

func _process(_delta: float) -> void:
	self.global_transform = camera_target.global_transform

	if click_result:
		click.emit(click_result)
		click_result = null

func _physics_process(_delta: float) -> void:
	if click_position != noclick_position:
		var ray_start = self.project_ray_origin(click_position)
		var ray_dir = self.project_ray_normal(click_position)
		var ray_end = ray_start + ray_dir * self.far

		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)

		click_result = space_state.intersect_ray(query)
		click_position = noclick_position
