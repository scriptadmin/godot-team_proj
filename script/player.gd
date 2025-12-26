extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

var is_dead := false

const SPEED = 90.0
const JUMP_VELOCITY = -230.0

func _ready():
	sprite.animation_finished.connect(_on_animation_finished)
	sprite.sprite_frames.set_animation_loop("death", false)

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
		sprite.play("move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("idle")

	# Check if landed
	if is_on_floor() and sprite.animation == "jump":
		sprite.play("idle")

	move_and_slide()

func _on_animation_finished():
	if sprite.animation == "death":
		get_tree().reload_current_scene()
