extends Camera3D

@export var camera_follow: Node3D
@export var click_listener: Node3D

const noclick_position := Vector2(-1, -1)
var click_position: Vector2 = noclick_position

func _ready() -> void:
	self.follow_camera()

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				click_position = event.position

func _process(_delta: float) -> void:
	self.follow_camera()

func _physics_process(_delta: float) -> void:
	if click_position != noclick_position:
		var ray_start := self.project_ray_origin(click_position)
		var ray_dir := self.project_ray_normal(click_position)
		var ray_end := ray_start + ray_dir * self.far

		var space_state := get_world_3d().direct_space_state
		var query := PhysicsRayQueryParameters3D.create(ray_start, ray_end)

		var click_result := space_state.intersect_ray(query)
		if click_listener:
			click_listener.click(click_result)
		click_position = noclick_position

func follow_camera():
	if self.camera_follow:
		self.global_transform = self.camera_follow.global_transform
