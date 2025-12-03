extends Node2D

const BULLET_SPEED := 340

func _process(delta):
	position.x += BULLET_SPEED * scale.x * delta

func _on_timer_timeout():
	self.queue_free()
