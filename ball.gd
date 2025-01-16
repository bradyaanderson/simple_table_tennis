extends CharacterBody2D

@export var speed: float = 300.0

func start_ball(start_position: Vector2):
    position = start_position
    var angle = randf_range(-PI / 4, PI / 4) + (PI if randf() > 0.5 else 0)
    velocity = Vector2(cos(angle), sin(angle)) * speed

func _physics_process(delta):
    var collision = move_and_collide(velocity * delta)
    
    print(get_viewport_rect().size)
    
    # Handle wall collisions
    if position.y <= 10 or position.y >= 590:
        velocity.y = -velocity.y
    
    # Add paddle collision check
    if collision:
        velocity = velocity.bounce(collision.get_normal())
