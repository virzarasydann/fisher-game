extends TileMapLayer

var player_is_near = false
var cancel = false
@onready var label_interaction: Label = $label_interaction
@onready var fisherman: CharacterBody2D = $"../../Entities/fisherman"

func _ready():
	label_interaction.visible = false



	
func _process(_delta):
		if Input.is_action_just_pressed("interact"):
			
			if player_is_near and not cancel:
				start_fishing()
			
			elif cancel:
				stop_fishing()
		#if Dialogic.current_timeline == null: 
			#mulai_dialog()

func start_fishing():
	cancel = true
	label_interaction.text = "Tekan E untuk membatalkan"
	
	print("Mulai Auto-Fishing...")
	
	
	while cancel:
		
		await fisherman.start_player_fishing()
		
		
		if cancel: 
			await get_tree().create_timer(1.0).timeout
	
	
	

func stop_fishing():
	cancel = false 
	label_interaction.text = "Tekan E untuk Mancing"
	
	fisherman.stop_player_fishing()
	
	
#func mulai_dialog():
	#
	#Dialogic.start("res://dialogic_component/timelines/go_to_beach_dialogue.dtl")
	#
	#await Dialogic.timeline_ended
	#
	#
	#var keputusan_player = Dialogic.VAR.get_variable("go_to_beach_dialogue.go_to_beach")
	#
	#
	#print("Keputusan Player: ", keputusan_player) 
	#
	#if keputusan_player == true:
		#interact() 
	#else:
		#print("Player menolak pergi ke pantai")

#func interact():
	#if target_scene_path != "":
		#get_tree().change_scene_to_file(target_scene_path)
	#else:
		#print("Target scene path kosong!")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "fisherman":
		
		#Dialogic.start("res://dialogic_component/timelines/go_to_beach_dialogue.dtl")
		player_is_near = true
		label_interaction.visible = true
		


func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_is_near = false
	label_interaction.visible = false
	


func _on_jump_area_body_entered(body: Node2D) -> void:
	body.can_jump = false


func _on_jump_area_body_exited(body: Node2D) -> void:
	body.can_jump = true
