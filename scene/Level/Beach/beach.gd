extends Node2D
@onready var sea_sound: AudioStreamPlayer = $Node/SeaSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sea_sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
