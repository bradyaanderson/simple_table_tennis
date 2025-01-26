extends CharacterBody2D

@export var speed: float = 300.0
@export var wait_time: float = 1

@onready var wait_timer = $WaitTimer

func reset_ball(start_position: Vector2):
   _disable_collisions()
   position = start_position
   _stop_movement()
   _start_launch_countdown()

func _physics_process(delta: float):
   var original_velocity = velocity
   var collision = move_and_collide(velocity * delta)
   
   if collision:
       _handle_collision(collision, original_velocity)

func _on_wait_timer_timeout() -> void:
   _enable_collisions()
   _launch_in_random_direction()

func _handle_collision(collision: KinematicCollision2D, original_velocity: Vector2) -> void:
   var collider = collision.get_collider()
   var normal = collision.get_normal()
   
   if collider.is_in_group("paddle"):
       _handle_paddle_collision(collider, collision)
   else:
       _bounce_off_wall(collision.get_normal())

func _handle_paddle_collision(paddle: Node, collision: KinematicCollision2D) -> void:
   var is_side_hit = _is_side_collision(collision.get_normal())
   
   if is_side_hit:
       _calculate_and_apply_paddle_bounce(paddle, collision.get_position())
   else:
       _disable_collisions()

func _bounce_off_wall(normal: Vector2) -> void:
   velocity = velocity.bounce(normal)

func _is_side_collision(normal: Vector2) -> bool:
   return abs(normal.x) > abs(normal.y)

func _calculate_and_apply_paddle_bounce(paddle: Node, collision_point: Vector2) -> void:
   var bounce_angle = paddle.get_bounce_angle(collision_point)
   var x_direction = _get_direction_from_paddle(paddle)
   velocity = _calculate_bounce_velocity(bounce_angle, x_direction)

func _get_direction_from_paddle(paddle: Node2D) -> int:
   return 1 if paddle.global_position.x < global_position.x else -1

func _calculate_bounce_velocity(angle: float, direction: int) -> Vector2:
   return Vector2(cos(angle) * direction, sin(angle)) * speed

func _launch_in_random_direction() -> void:
   var angle = _calculate_random_launch_angle()
   velocity = Vector2(cos(angle), sin(angle)) * speed

func _calculate_random_launch_angle() -> float:
   var base_angle = randf_range(-PI / 4, PI / 4)
   var direction_modifier = PI if randf() > 0.5 else 0
   return base_angle + direction_modifier

func _start_launch_countdown() -> void:
   wait_timer.start(wait_time)

func _stop_movement() -> void:
   velocity = Vector2.ZERO

# Private methods - Collision state
func _enable_collisions() -> void:
   $CollisionShape.disabled = false
   
func _disable_collisions() -> void:
   $CollisionShape.disabled = true
