extends CharacterBody3D

@export var speed: float = 1

var velocity_direction := Vector3.ZERO

var autopilot_target: Node3D = null
var hydrating_target: Node3D = null

func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	var x_input := Input.get_axis("forward", "backward")
	var z_input := Input.get_axis("right", "left")

	if x_input != 0 or z_input != 0:
		self.autopilot_off()
		self.hydrate_off()
		self.velocity_direction = Vector3(x_input, 0, z_input).normalized()
		self.horizontal_look_at(self.position + self.velocity_direction)
	elif self.autopilot_target:
		self.autopilot_process()
	else:
		self.velocity_direction = Vector3.ZERO
func _physics_process(_delta: float) -> void:
	self.velocity = velocity_direction * speed
	move_and_slide()


func _on_interaction_area_area_entered(area: Area3D) -> void:
	if self.autopilot_target and area.get_parent() == self.autopilot_target:
		self.hydrate_on(self.autopilot_target)
		self.autopilot_off()
		self.velocity_direction = Vector3.ZERO
func _on_interaction_area_area_exited(area: Area3D) -> void:
	pass


func autopilot_on(target: Node3D):
	self.autopilot_target = target
	var interaction_area: Area3D = self.autopilot_target.find_child("InteractionArea", false)
	interaction_area.set_visible(true)
	self.autopilot_process()
	if interaction_area.overlaps_area($InteractionArea):
		self.hydrate_on(self.autopilot_target)
		self.autopilot_off()
		self.velocity_direction = Vector3.ZERO
func autopilot_off():
	if self.autopilot_target:
		self.autopilot_target.find_child("InteractionArea", false).set_visible(false)
		self.autopilot_target = null
func autopilot_process():
	var displacement := self.autopilot_target.global_position - self.global_position
	displacement.y = 0
	self.velocity_direction = displacement.normalized()
	self.horizontal_look_at(self.position + displacement)


func hydrate_on(target):
	self.hydrating_target = target
	self.hydrating_target.hydrate_start()
func hydrate_off():
	if self.hydrating_target:
		self.hydrating_target.hydrate_stop()
		self.hydrating_target = null


func horizontal_look_at(target: Vector3):
	$Pivot.look_at(target, self.up_direction, true)
	$Pivot.rotation.x = 0
	$Pivot.rotation.z = 0
