extends Area2D

@export var speed: float = 300

# Keys for controlling the paddle
@export var move_up_key: String = ""
@export var move_down_key: String = ""

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
