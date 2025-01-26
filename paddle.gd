extends StaticBody2D

@export var speed: float = 300

# Keys for controlling the paddle
@export var move_up_key: String = ""
@export var move_down_key: String = ""

@export var max_bounce_angle = PI / 4
@export var half_height: float = 50

func get_bounce_angle(collision_point: Vector2) -> float:
    # This calculates how far from the center of the paddle the collision occurred
    var offset = collision_point.y - global_position.y
    var normalized_offset = clamp(offset / half_height, -1.0, 1.0)
    
    # Multiply by our maximum bounce angle
    return normalized_offset * max_bounce_angle

func _physics_process(delta: float) -> void:
    var direction = 0

    # Check for movement input
    if Input.is_action_pressed(move_up_key):
        direction -= 1
    if Input.is_action_pressed(move_down_key):
        direction += 1

    # Move the paddle
    position.y += direction * speed * delta

    # Prevent paddle from going out of bounds
    position.y = clamp(position.y, 50, 550)
