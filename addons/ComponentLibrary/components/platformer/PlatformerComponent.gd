class_name PlatformerComponent extends Node

@export var character_body: CharacterBody2D
@export var MAX_SPEED: float
@export var ACCELERATION: float
@export var DECELERATION: float
@export var JUMP_STRENGTH: float
@export var GRAVITY: float
@export var MAX_FALL_SPEED: float

@export var look_at_component: LookAtComponent

var moved_horizontally_this_frame: bool = false

func move_horizontally(direction: float) -> void:
	var delta = get_physics_process_delta_time()
	if direction:
		var target = direction * MAX_SPEED
		character_body.velocity.x = move_toward(character_body.velocity.x, target, ACCELERATION * delta)
	else:
		decelerate()
	
	moved_horizontally_this_frame = true

func move_right() -> void:
	move_horizontally(1)

func move_left() -> void:
	move_horizontally(-1)

func decelerate() -> void:
	var delta = get_physics_process_delta_time()
	character_body.velocity.x = move_toward(character_body.velocity.x, 0, DECELERATION * delta)

func move_vertically() -> void:
	var delta = get_physics_process_delta_time()

	# Apply gravity
	if not character_body.is_on_floor():
		character_body.velocity.y += GRAVITY * delta

	# Cap fall speed
	if character_body.velocity.y > MAX_FALL_SPEED:
		character_body.velocity.y = MAX_FALL_SPEED

func jump() -> void:
	character_body.velocity.y = -JUMP_STRENGTH

func can_jump() -> bool:
	return character_body.is_on_floor()

func _physics_process(delta: float) -> void:
	update_velocity.call_deferred()

func update_velocity() -> void:
	# If hasn't moved horizontally this frame, decelerate
	if not moved_horizontally_this_frame:
		decelerate()
	
	# Move vertically
	move_vertically()

	# Move and slide
	character_body.move_and_slide()

	# Reset moved horizontally flag
	moved_horizontally_this_frame = false

func _process(delta: float) -> void:
	if look_at_component:
		look_at_component.look_in_direction(character_body.velocity)