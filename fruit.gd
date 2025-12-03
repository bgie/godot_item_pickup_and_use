extends Node2D

func pickup():
	z_index = 1

func drop():
	z_index = -1

func use():
	# TODO play eating sound, reduce hunger
	self.queue_free()
