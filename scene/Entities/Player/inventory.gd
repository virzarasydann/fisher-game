extends CanvasLayer 

@onready var grid_container = $Background/GridContainer

func _ready():
	visible = false 

func _input(event):
	
	if event.is_action_pressed("inventory"):
		visible = !visible
		if visible:
			update_tampilan_tas()

func update_tampilan_tas():
	
	for child in grid_container.get_children():
		child.queue_free()
	

	for item in GameData.inventory:
		
		
		var slot = TextureRect.new()
		slot.texture = item.icon
		
		
		slot.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		slot.custom_minimum_size = Vector2(64, 64)
		slot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		
		grid_container.add_child(slot)
