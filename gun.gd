extends Node2D

@onready var bullet_spawn_marker_2d : Node2D = $BulletSpawnMarker2D
var bullet_scene := preload("res://bullet.tscn")

func pickup():
	z_index = 1

func drop():
	z_index = -1

func use():
	var bullet : Node2D = bullet_scene.instantiate()
	bullet.position = bullet_spawn_marker_2d.global_position
	bullet.scale.x = self.scale.x
	get_parent().add_child(bullet)
