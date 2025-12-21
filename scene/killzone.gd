extends Area2D

@onready var timer = $Timer



func _on_body_entered(body):
	print("you died")
	Engine.time_scale = 0.3
	if body.is_in_group("Player"):
		body.play_death_animation()  # 플레이어 스크립트에 정의된 함수 호출
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
