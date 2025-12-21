extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var anim_player = $AnimationPlayer   # AnimationPlayer 노드 참조
var is_playing := false

const SPEED = 75.0
const JUMP_VELOCITY = -200.0

func play_death_animation():
	sprite.play("death")

func _process(delta: float) -> void:
	if not is_playing:
		sprite.play("idle")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		
		velocity.y = JUMP_VELOCITY
		is_playing = true
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
