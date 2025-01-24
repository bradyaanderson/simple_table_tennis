extends Node2D

signal left_score
signal right_score

func _ready() -> void:
    randomize()
    reset_ball()

func _on_reset_game() -> void:
    reset_ball()

func reset_ball():
    var viewport_size = get_viewport().size
    var start_pos = viewport_size / 2
    $Ball.start_ball(start_pos)

func _on_right_score_area_body_entered(body: Node2D) -> void:
    left_score.emit()

func _on_left_score_area_body_entered(body: Node2D) -> void:
    right_score.emit()
