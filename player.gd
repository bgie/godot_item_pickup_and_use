extends Node2D

const WALK_SPEED := 40

@onready var sprite = $Sprite2D
@onready var carry_item_marker_2d = $CarryItemMarker2D

var item_to_pick_up : Node2D = null
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
	elif event.is_action_pressed("pickup") && item_to_pick_up != null:
		if item_carried != null:
			item_carried.drop()
			item_carried = null
		item_to_pick_up.pickup()
		item_carried = item_to_pick_up
		item_to_pick_up = null
	elif event.is_action_pressed("drop") && item_carried != null:
		item_carried.drop()
		item_carried = null


func _on_hit_box_area_2d_area_entered(area: Area2D):
	if area.get_parent().has_method("pickup"):
		item_to_pick_up = area.get_parent()

func _on_hit_box_area_2d_area_exited(area: Area2D):
	# note: this code has limitations. Might not handle overlapping items correctly.
	if item_to_pick_up == area.get_parent():
		item_to_pick_up = null
