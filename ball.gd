extends Area2D

@export var speed: float = 300.0  # Ball speed
var velocity: Vector2 = Vector2.ZERO  # Ball movement direction and speed
    
func start_ball(start_position: Vector2):
    position = start_position
    var angle = randf_range(-PI / 4, PI / 4) + (PI if randf() > 0.5 else 0)
    velocity = Vector2(cos(angle), sin(angle)) * speed

func _physics_process(delta):
    # Move the ball
    position += velocity * delta

    # Bounce off the top and bottom walls
    if position.y <= 10 or position.y >= 590:  # Screen edges at 10px margin
        velocity.y = -velocity.y
