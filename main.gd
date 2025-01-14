extends Node2D

func _ready() -> void:
    randomize()
    reset_ball()

func _on_reset_game() -> void:
    reset_ball()

func reset_ball():
    var viewport_size = get_viewport().size
    var start_pos = viewport_size / 2
    $Ball.start_ball(start_pos)
