extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var player: AnimatedSprite2D = $"AnimatedSprite2D"
@export var audio: AudioStreamPlayer2D


@export var is_top_down_mode: bool = false 

func _physics_process(_delta: float) -> void:

	# --- BAGIAN INI YANG DIUBAH ---
	if Dialogic.current_timeline != null:
		player.animation = "idle"
		audio.stop()
		
		if is_top_down_mode:
			# Kalau di Village (Top Down), boleh diam total
			velocity = Vector2.ZERO
		else:
			# Kalau di Main (Platformer), HANYA matikan gerak X (Kiri/Kanan)
			velocity.x = 0
			
			# TAPI biarkan gravitasi tetap jalan (Sumbu Y)
			# Supaya kaki player tetap menempel (menekan) lantai
			if not is_on_floor():
				velocity += get_gravity() * _delta
		
		move_and_slide()
		return
	# -------------------------------

	if is_top_down_mode:
		gerak_top_down(_delta)
	else:
		gerak_platformer(_delta)

	move_and_slide()


func gerak_platformer(_delta):
	
	if not is_on_floor():
		velocity += get_gravity() * _delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		player.animation = "walk"
		player.flip_h = direction < 0 
		velocity.x = direction * SPEED
		if not audio.playing:
			audio.play()
	else:
		player.animation = "idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)
		audio.stop()


func gerak_top_down(_delta):
	
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * SPEED
		
		
		player.animation = "walk"
		
		
		if input_vector.x != 0:
			player.flip_h = input_vector.x < 0
			
		if not audio.playing:
			audio.play()
	else:
		velocity = Vector2.ZERO
		player.animation = "idle"
		audio.stop()
