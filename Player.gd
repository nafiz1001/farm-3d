extends CharacterBody3D

@export var speed = 100

func _input(_event):
	pass

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
		look_at(self.position + Vector3(target_velocity.z, 0, -target_velocity.x))
	else:
		self.velocity = Vector3.ZERO
	move_and_slide()
