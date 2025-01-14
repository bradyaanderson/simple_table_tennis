extends Control
signal reset_game

func _on_button_pressed() -> void:
    reset_game.emit()
