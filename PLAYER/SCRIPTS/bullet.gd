extends CharacterBody2D

@export var speed = 1200


func _physics_process(delta):
	position += transform.x * speed * delta


func _on_bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
