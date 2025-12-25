extends Node2D

@onready var audio_traverse_town: AudioStreamPlayer2D = $AudioTraverseTown
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.VAR.go_to_beach_dialogue.go_to_beach = false
	audio_traverse_town.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
