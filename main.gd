extends Node2D

signal left_score
signal right_score

func _ready() -> void:
   _initialize_game()

func _on_reset_game() -> void:
   _reset_ball_to_center()

func _on_right_score_area_body_entered(_body: Node2D) -> void:
   _award_point_to_left_player()

func _on_left_score_area_body_entered(_body: Node2D) -> void:
   _award_point_to_right_player()

func _initialize_game() -> void:
   randomize()
   _reset_ball_to_center()

func _reset_ball_to_center() -> void:
   var center_position = _calculate_center_position()
   $Ball.reset_ball(center_position)

func _calculate_center_position() -> Vector2:
   return get_viewport().size / 2

func _award_point_to_left_player() -> void:
   left_score.emit()

func _award_point_to_right_player() -> void:
   right_score.emit()
