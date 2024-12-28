@tool
class_name HitboxComponent extends Area2D

## An Area2D that represents a damaging area of an object.
## It listens for collisions with HurtboxComponents, which represent vulnerable areas of other objects.
## The HitboxComponent should exist on one or more collision layers and no collision masks.

signal hit_hurtbox(hurtbox: HurtboxComponent)

@export var damage: int = 1 : set = set_damage, get = get_damage
@export var knockback: float = 0
@export var enabled: bool = true : set = set_enabled

func update_collision_shape_color() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			child.debug_color = Color(1, 0, 0, 0.1)

func _ready() -> void:
	update_collision_shape_color()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update_collision_shape_color()

func set_damage(_damage: int):
	damage = _damage

func get_damage() -> int:
	return damage

func has_knockback() -> bool:
	return knockback > 0

func set_enabled(_enabled: bool) -> void:
	enabled = _enabled
	for child in get_children():
		if child is CollisionShape2D:
			child.disabled = not enabled
