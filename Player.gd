class_name Player extends CharacterBody3D

@export var speed: float = 1

var velocity_direction := Vector3.ZERO

var autopilot_target: Crop = null
var hydrating_target: Crop = null

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
	if self.autopilot_target and area.get_parent() == self.autopilot_target.get_soil():
		self.hydrate_on(self.autopilot_target)
		self.autopilot_off()
		self.velocity_direction = Vector3.ZERO
func _on_interaction_area_area_exited(area: Area3D) -> void:
	pass


func autopilot_on(target: Crop):
	self.autopilot_target = target
	var interaction_area := target.get_interaction_area()
	interaction_area.outline = true
	self.autopilot_process()
	if interaction_area.overlaps_area($InteractionArea):
		self.hydrate_on(self.autopilot_target)
		self.autopilot_off()
		self.velocity_direction = Vector3.ZERO
func autopilot_off():
	if self.autopilot_target:
		self.autopilot_target.get_interaction_area().outline = false
		self.autopilot_target = null
func autopilot_process():
	var displacement := self.autopilot_target.global_position - self.global_position
	displacement.y = 0
	self.velocity_direction = displacement.normalized()
	self.horizontal_look_at(self.position + displacement)


func hydrate_on(target: Crop):
	self.hydrating_target = target
	self.hydrating_target.get_soil().hydrate_start()
func hydrate_off():
	if self.hydrating_target:
		self.hydrating_target.get_soil().hydrate_stop()
		self.hydrating_target = null


func horizontal_look_at(target: Vector3):
	$Pivot.look_at(target, self.up_direction, true)
	$Pivot.rotation.x = 0
	$Pivot.rotation.z = 0
