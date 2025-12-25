extends StaticBody2D

var player_is_near = false

@onready var label_interaction: Label = $label_interaction
@export_file("*.tscn") var target_scene_path = ""
func _ready():
	label_interaction.visible = false


func _process(_delta):
	
	if player_is_near and Input.is_action_just_pressed("interact"):
		if Dialogic.current_timeline == null: 
			mulai_dialog()

func mulai_dialog():
	
	Dialogic.start("res://dialogic_component/timelines/go_to_beach_dialogue.dtl")
	
	await Dialogic.timeline_ended
	
	
	var keputusan_player = Dialogic.VAR.get_variable("go_to_beach_dialogue.go_to_beach")
	
	
	print("Keputusan Player: ", keputusan_player) 
	
	if keputusan_player == true:
		interact() 
	else:
		print("Player menolak pergi ke pantai")

func interact():
	if target_scene_path != "":
		get_tree().change_scene_to_file(target_scene_path)
	else:
		print("Target scene path kosong!")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "fisherman":
		
		#Dialogic.start("res://dialogic_component/timelines/go_to_beach_dialogue.dtl")
		player_is_near = true
		label_interaction.visible = true 


func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_is_near = false
	label_interaction.visible = false
