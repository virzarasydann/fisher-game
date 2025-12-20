extends StaticBody2D

var player_is_near = false

@onready var label_interaction: Label = $label_interaction
@export_file("*.tscn") var target_scene_path = ""
func _ready():
	label_interaction.visible = false


func _process(_delta):
	
	if player_is_near and Input.is_action_just_pressed("interact"): 
		interact()

func interact():
	get_tree().change_scene_to_file(target_scene_path)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "fisherman":
		Dialogic.VAR.first_dialogue.is_at_gate = true
		Dialogic.start("res://dialogic_component/timelines/first_dialogue.dtl")
		player_is_near = true
		label_interaction.visible = true 


func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_is_near = false
	label_interaction.visible = false
