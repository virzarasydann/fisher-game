extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_jump = true
var is_fishing = false


@onready var player: AnimatedSprite2D = $"AnimatedSprite2D"
@export var audio: AudioStreamPlayer2D
@export var is_top_down_mode: bool = false 
@onready var item_result_sprite: Sprite2D = $ItemResult



func _physics_process(_delta: float) -> void:

	
	if Dialogic.current_timeline != null:
		player.animation = "idle"
		audio.stop()
		if is_top_down_mode:
			velocity = Vector2.ZERO
		else:
			velocity.x = 0
			if not is_on_floor():
				velocity += get_gravity() * _delta
		move_and_slide()
		return

	
	if is_fishing:
	
		audio.stop() 
		
	
		if is_top_down_mode:
			velocity = Vector2.ZERO
		else:
			velocity.x = 0
			if not is_on_floor():
				velocity += get_gravity() * _delta
		
		
		
		move_and_slide()
		return 

	if is_top_down_mode:
		gerak_top_down(_delta)
	else:
		gerak_platformer(_delta)

	move_and_slide()

func start_player_fishing():
	is_fishing = true
	velocity = Vector2.ZERO 
	
	
	if player.sprite_frames.has_animation("hook_idle"):
		
		is_fishing = true
		item_result_sprite.visible = false 
		player.play("hook_idle")
		await player.animation_finished
		
		
		var waktu_tunggu = randf_range(1.0, 3.0)
		await get_tree().create_timer(waktu_tunggu).timeout
		
	
		player.play("hook_fish") 
		
		
		var hasil_id = acak_tangkapan()
		var gambar_ikan = GameData.database_ikan[hasil_id]
		GameData.add_item(gambar_ikan)
		
		item_result_sprite.texture = gambar_ikan.icon
		item_result_sprite.position.y = -50
		item_result_sprite.visible = true
		
		
		
		await player.animation_finished
		
		stop_player_fishing()
	else:
		print("Peringatan: Player tidak punya animasi 'hook'")
		player.play("idle")

func stop_player_fishing():
	is_fishing = false
	player.play("idle")
	
	await get_tree().create_timer(2.0).timeout
	item_result_sprite.visible = false

func gerak_platformer(_delta):
	
	if not is_on_floor():
		velocity += get_gravity() * _delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and can_jump:
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


func acak_tangkapan():
	
	var hoki = randi_range(0, 100)
	if hoki < 40: 
		return "sampah"
		
	elif hoki < 75: 
		return "ikan_mas"
		
	elif hoki < 95:
		return "ikan_hijau"
		
	else:
		
		return "ikan_legendary"
