extends Camera3D

signal click(result: Dictionary)

var default_transform: Transform3D

var remote_transform: RemoteTransform3D

@export var camera_follow_: Node3D
var camera_follow: Node3D:
	get:
		return camera_follow_
	set(target):
		if camera_follow and remote_transform.is_inside_tree() and camera_follow.has_node(remote_transform.get_path()):
			camera_follow.remove_child(remote_transform)
		camera_follow_ = target
		if target:
			target.add_child(remote_transform)
		else:
			transform = default_transform

const noclick_position := Vector2(-1, -1)
var click_position: Vector2 = noclick_position

func _ready() -> void:
	default_transform = Transform3D(transform)

	remote_transform = RemoteTransform3D.new()
	remote_transform.name = "RemoteTransform3D"
	remote_transform.update_position = true
	remote_transform.update_rotation = true
	remote_transform.update_scale = true
	remote_transform.use_global_coordinates = true
	remote_transform.remote_path = get_path()

	if camera_follow_:
		camera_follow = camera_follow_
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				click_position = event.position
func _physics_process(_delta: float) -> void:
	if click_position != noclick_position:
		var ray_start := project_ray_origin(click_position)
		var ray_dir := project_ray_normal(click_position)
		var ray_end := ray_start + ray_dir * far

		var space_state := get_world_3d().direct_space_state
		var query := PhysicsRayQueryParameters3D.create(ray_start, ray_end)

		var click_result := space_state.intersect_ray(query)
		if click_result:
			click.emit(click_result)
		click_position = noclick_position
