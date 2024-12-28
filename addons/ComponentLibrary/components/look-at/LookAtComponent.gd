@tool
class_name LookAtComponent extends Node2D

@export var nodes: Array[Node2D] = []

enum NamedEnum {SMOOTH, FOUR_DIRECTIONS, EIGHT_DIRECTIONS, FLIP_HORIZONTAL, FLIP_VERTICAL}
@export var look_at_mode: NamedEnum = NamedEnum.SMOOTH

var looking_direction := Vector2.RIGHT

# Threshold to prevent changing looking direction at very small values
@export var MIN_LOOKING_DIRECTION_THRESHOLD: float = 0.1

@export var preview_look_at_mouse: bool = false

func look_at_position(target: Vector2) -> void:
	looking_direction = target - global_position

func look_at_node(node: Node2D) -> void:
	look_at_position(node.global_position)

func look_in_direction(direction: Vector2) -> void:
	looking_direction = direction

func get_snapped_angle(angle: float, snap_to: float) -> float:
	return round(angle / snap_to) * snap_to

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if preview_look_at_mouse:
			look_at_position(get_viewport().get_mouse_position())
		else:
			looking_direction = Vector2.RIGHT

	if not has_direction():
		return

	match look_at_mode:
		NamedEnum.SMOOTH:
			update_smooth()
		NamedEnum.FOUR_DIRECTIONS:
			update_four_directions()
		NamedEnum.EIGHT_DIRECTIONS:
			update_eight_directions()
		NamedEnum.FLIP_HORIZONTAL:
			update_flip_horizontal()
		NamedEnum.FLIP_VERTICAL:
			update_flip_vertical()

func update_smooth() -> void:
	var angle = looking_direction.angle()
	for node in nodes:
		node.rotation = angle

func update_four_directions() -> void:
	var angle = looking_direction.angle()
	for node in nodes:
		node.rotation = get_snapped_angle(looking_direction.angle(), PI / 2)

func update_eight_directions() -> void:
	var angle = looking_direction.angle()
	for node in nodes:
		node.rotation = get_snapped_angle(looking_direction.angle(), PI / 4)

func update_flip_horizontal() -> void:
	for node in nodes:
		node.scale.x = 1 if looking_direction.x > 0 else -1

func update_flip_vertical() -> void:
	for node in nodes:
		node.scale.y = 1 if looking_direction.y > 0 else -1

func get_direction() -> Vector2:
	return looking_direction.normalized()

func has_direction() -> bool:
	return looking_direction.length() >= MIN_LOOKING_DIRECTION_THRESHOLD

func is_facing_right() -> bool:
	return has_direction() and looking_direction.x > 0
