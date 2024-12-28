@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("BulletComponent", "Node", preload("components/bullet/BulletComponent.gd"), null)
	add_custom_type("DetectorComponent", "Area2D", preload("components/detector/DetectorComponent.gd"), null)
	add_custom_type("FlashComponent", "Node", preload("components/flash/FlashComponent.gd"), null)
	add_custom_type("HealthComponent", "Node", preload("components/health/HealthComponent.gd"), null)
	add_custom_type("HitboxComponent", "Area2D", preload("components/hitbox/HitboxComponent.gd"), null)
	add_custom_type("HurtboxComponent", "Area2D", preload("components/hurtbox/HurtboxComponent.gd"), null)
	add_custom_type("KnockbackComponent", "Node", preload("components/knockback/KnockbackComponent.gd"), null)
	add_custom_type("LookAtComponent", "Node2D", preload("components/look-at/LookAtComponent.gd"), null)
	add_custom_type("PlatformerComponent", "Node", preload("components/platformer/PlatformerComponent.gd"), null)
	add_custom_type("VelocityComponent", "Node", preload("components/velocity/VelocityComponent.gd"), null)

func _exit_tree() -> void:
	remove_custom_type("BulletComponent")
	remove_custom_type("DetectorComponent")
	remove_custom_type("FlashComponent")
	remove_custom_type("HealthComponent")
	remove_custom_type("HitboxComponent")
	remove_custom_type("HurtboxComponent")
	remove_custom_type("KnockbackComponent")
	remove_custom_type("LookAtComponent")
	remove_custom_type("PlatformerComponent")
	remove_custom_type("VelocityComponent")
