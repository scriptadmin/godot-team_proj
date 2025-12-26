extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if body.name == "Player" and not body.is_dead:
		print("you died")
		body.is_dead = true
		body.sprite.play("death")



func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
