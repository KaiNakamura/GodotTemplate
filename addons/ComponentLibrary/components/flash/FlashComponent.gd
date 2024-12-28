class_name FlashComponent extends Node

@export var sprite: Sprite2D
@export var flash_shader_material: ShaderMaterial = preload("res://addons/ComponentLibrary/components/flash/shaders/WhiteShaderMaterial.tres")
@export var duration: float = 0.1
@export var num_flashes: int = 1
@export var disable_hurtbox_while_flashing: bool = true

var sprite_shader_material: ShaderMaterial

var is_flashing: bool = false

func _ready() -> void:
	sprite_shader_material = sprite.material

func flash() -> void:
	is_flashing = true

	var wait_time = duration / (2 * num_flashes - 1)
	for i in range(num_flashes):
		sprite.material = flash_shader_material
		await get_tree().create_timer(wait_time).timeout
		sprite.material = sprite_shader_material

		if i < num_flashes - 1:
			await get_tree().create_timer(wait_time).timeout
	
	is_flashing = false
