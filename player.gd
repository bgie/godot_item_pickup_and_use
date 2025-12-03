extends Node2D

const WALK_SPEED := 40

@onready var carry_item_marker_2d = $CarryItemMarker2D
@onready var hit_box_area_2d : Area2D = $HitBoxArea2D

var item_carried : Node2D = null

func _process(delta):
	var walk := Input.get_axis("ui_left", "ui_right")
	if walk < 0:
		scale.x = -1
	elif walk > 0:
		scale.x = 1
	position.x += walk * delta * WALK_SPEED
	
	if item_carried != null:
		if is_instance_valid(item_carried):
			item_carried.position = carry_item_marker_2d.global_position
			item_carried.scale.x = scale.x
		else:
			item_carried = null

func _unhandled_key_input(event: InputEvent):
	if event.is_action_pressed("ui_accept") && item_carried && item_carried.has_method("use"):
		item_carried.use()
	elif event.is_action_pressed("pickup"):
		for overlapping_area in hit_box_area_2d.get_overlapping_areas():
			var item_to_pick_up : Node2D = overlapping_area.get_parent()
			if item_to_pick_up != item_carried:
				if item_carried != null:
					item_carried.drop()
					item_carried = null
				item_to_pick_up.pickup()
				item_carried = item_to_pick_up
				break
	elif event.is_action_pressed("drop") && item_carried != null:
		item_carried.drop()
		item_carried = null
