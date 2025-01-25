extends CharacterBody2D

@export var speed: float = 300.0
@onready var wait_timer = $WaitTimer

func start_ball(start_position: Vector2):
    position = start_position
    # Set initial velocity to zero while waiting
    velocity = Vector2.ZERO
    wait_timer.start(1.0)

func _physics_process(delta):
    var collision = move_and_collide(velocity * delta)
    
    # Add paddle collision check
    if collision:
        velocity = velocity.bounce(collision.get_normal())

func _on_wait_timer_timeout() -> void:
    # After timer expires, set the initial velocity
    var angle = randf_range(-PI / 4, PI / 4) + (PI if randf() > 0.5 else 0)
    velocity = Vector2(cos(angle), sin(angle)) * speed
