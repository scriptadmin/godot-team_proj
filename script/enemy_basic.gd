extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $RayCast2D
@onready var body_collision: CollisionShape2D = $CollisionShape2D
@onready var killzone_shape: CollisionShape2D = $"killzone/CollisionShape2D"

var direction: int = 1
const SPEED: float = 50.0

func _ready() -> void:
	floor_snap_length = 0
	safe_margin = 0.1
	sprite.play("move")
	_update_raycast()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	raycast.force_raycast_update()
	if not raycast.is_colliding() and is_on_floor():
		_reverse_direction()

	if is_on_wall():
		_reverse_direction()

	velocity.x = direction * SPEED
	sprite.flip_h = direction < 0
	move_and_slide()

func _reverse_direction() -> void:
	direction *= -1
	_update_raycast()

	# 콜리전만 반전 방향을 반대로 적용
	body_collision.position.x = -abs(body_collision.position.x) * direction
	killzone_shape.position.x = -abs(killzone_shape.position.x) * direction

func _update_raycast() -> void:
	raycast.position = Vector2(direction * 20, 3)
	raycast.target_position = Vector2(direction * 10, 25)
