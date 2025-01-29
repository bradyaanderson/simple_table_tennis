extends Node2D

signal score(side)

func _ready() -> void:
   _initialize_game()

func _on_reset_game() -> void:
   _reset_ball_to_center()

func _on_right_score_area_body_entered(_body: Node2D) -> void:
   _award_point(Global.Side.LEFT)

func _on_left_score_area_body_entered(_body: Node2D) -> void:
   _award_point(Global.Side.RIGHT)

func _initialize_game() -> void:
   randomize()
   _reset_ball_to_center()

func _reset_ball_to_center() -> void:
   var center_position = _calculate_center_position()
   $Ball.reset_ball(center_position)

func _calculate_center_position() -> Vector2:
   return get_viewport().size / 2

func _award_point(side: Global.Side) -> void:
   score.emit(side)
   _update_scores_labels()

func _update_scores_labels() -> void:
  get_tree().call_group("score_labels", "on_score_change")
