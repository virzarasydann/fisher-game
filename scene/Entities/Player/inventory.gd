extends CanvasLayer 

@onready var grid_container = $Background/CenterContainer/GridContainer
@onready var background: Panel = $Background
@onready var button_tas: TextureButton = $ButtonTas
@onready var label_uang: Label = $Background/HBoxContainer/LabelUang

var slot_scene = preload("res://scene/Entities/Player/InventorySlot.tscn")
func _ready():
	background.visible = false 
	button_tas.pressed.connect(_on_tombol_tas_ditekan)
	update_ui_uang(GameData.coins)
	
	GameData.uang_berubah.connect(update_ui_uang)

func _input(event):
	
	if event.is_action_pressed("inventory"):
		toggle_inventory()

func toggle_inventory():
	background.visible = !background.visible
	
	if background.visible:
		update_tampilan_tas()
		

func update_ui_uang(nilai_baru):
	label_uang.text = str(nilai_baru)
	
	
func _on_tombol_tas_ditekan():
	toggle_inventory()
	
func update_tampilan_tas():
	
	for child in grid_container.get_children():
		child.queue_free()
	

	for item in GameData.inventory:
		
		var slot_baru = slot_scene.instantiate()
		
		var icon_node = slot_baru.get_node("MarginContainer/Icon")
		icon_node.texture = item.icon
		
		slot_baru.tooltip_text = item.name
		
		grid_container.add_child(slot_baru)
