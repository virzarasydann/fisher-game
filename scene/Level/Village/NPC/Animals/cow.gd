extends CharacterBody2D

@export var speed = 50.0

@onready var timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $CowSprite

# 1 = Kanan, -1 = Kiri
var direction = 1 

func _ready():
	
	timer.timeout.connect(_on_timer_timeout)
	
	pilih_arah_baru()

func _physics_process(delta):
	
	velocity.x = direction * speed
	
	

	move_and_slide()
	
	
	update_animasi()

func update_animasi():
	if direction != 0:
		
		if not animated_sprite.is_playing(): 
			animated_sprite.play("run")
		
		
		animated_sprite.flip_h = (direction == 1)
	else:
		
		animated_sprite.stop()
		animated_sprite.frame = 0 


func _on_timer_timeout():
	pilih_arah_baru()

func pilih_arah_baru():
	# Masukkan 0 supaya dia bisa istirahat
	direction = randi_range(-1, 1)
	
	# Timer random
	timer.wait_time = randf_range(1.0, 2.0)
