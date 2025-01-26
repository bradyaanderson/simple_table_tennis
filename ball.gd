extends CharacterBody2D

@export var speed: float = 300.0
@onready var wait_timer = $WaitTimer

func start_ball(start_position: Vector2):
    $CollisionShape.disabled = true
    position = start_position
    # Set initial velocity to zero while waiting
    velocity = Vector2.ZERO
    wait_timer.start(1.0)

func _physics_process(delta: float):
    var original_velocity = velocity
    var collision = move_and_collide(velocity * delta)
    
    # Add paddle collision check
    if collision:
        _handle_collision(collision, original_velocity)

func _on_wait_timer_timeout() -> void:
    # After timer expires, set the initial velocity
    $CollisionShape.disabled = false
    
    var angle = randf_range(-PI / 4, PI / 4) + (PI if randf() > 0.5 else 0)
    velocity = Vector2(cos(angle), sin(angle)) * speed

func _handle_collision(collision: KinematicCollision2D, original_velocity: Vector2) -> void:
    var collider = collision.get_collider()
    var normal = collision.get_normal()

    if collider.is_in_group("paddle"):
        if abs(normal.x) > abs(normal.y):
            velocity = _calc_bounce_velocity_from_paddle(collider, collision.get_position())
        else:
            $CollisionShape.disabled = true
    else:
        velocity = velocity.bounce(collision.get_normal())

func _calc_bounce_velocity_from_paddle(paddle: Node, collision_point: Vector2) -> Vector2:
 # Get the bounce angle from the paddle
    var bounce_angle = paddle.get_bounce_angle(collision_point)

    # Determine the bounce direction based on the paddle's position
    # Assuming paddles are placed on the left and right sides of the screen
    var is_left_paddle = paddle.global_position.x < global_position.x

    # Flip X velocity depending on whether it's a left or right paddle
    var x_direction = 1 if is_left_paddle else -1

    # Construct the velocity vector with correct direction
    return Vector2(cos(bounce_angle) * x_direction, sin(bounce_angle)) * speed
