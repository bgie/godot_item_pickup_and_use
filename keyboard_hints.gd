extends CanvasLayer

@onready var pickup_item_hint = $PickupItemHint


func _on_player_show_keyboard_hint(key: String):
	if key == "P":
		pickup_item_hint.visible = true
	else:
		pickup_item_hint.visible = false
