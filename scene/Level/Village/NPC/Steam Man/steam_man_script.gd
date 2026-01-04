extends AnimatedSprite2D

@onready var player: AnimatedSprite2D = $"."
var player_is_near = false
@onready var label_interaction: Label = $"../label_interaction"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_interaction.visible = false
	play("attack")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if player_is_near and Input.is_action_just_pressed("interact"):
		if Dialogic.current_timeline == null: 
			mulai_dialog()

func mulai_dialog():
	
	Dialogic.start("res://dialogic_component/timelines/npc_sell_dialogue.dtl")
	
	await Dialogic.timeline_ended
	
	
	var keputusan_player = Dialogic.VAR.get_variable("sell_all_fish.sell_all_fish")
	
	
	print("Keputusan Player: ", keputusan_player) 
	
	if keputusan_player == true:
		interact() 
	else:
		print("Player menolak menjual")

func interact():
	var pendapatan = GameData.jual_semua_ikan()
	
	if pendapatan > 0:
		print("Transaksi Berhasil! Player dapat: ", pendapatan)
	else:
		print("Tas player kosong, tidak ada yang dijual.")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "fisherman":
		
		#Dialogic.start("res://dialogic_component/timelines/go_to_beach_dialogue.dtl")
		player_is_near = true
		label_interaction.visible = true 


func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_is_near = false
	label_interaction.visible = false
