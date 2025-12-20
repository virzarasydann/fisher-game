extends Node2D


@onready var audio_traverse_town: AudioStreamPlayer2D = $Audio/AudioTraverseTown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.VAR.first_dialogue.is_at_gate = false
	Dialogic.start("res://dialogic_component/timelines/first_dialogue.dtl")
	audio_traverse_town.play()
