extends Label

@export_enum("Left", "Right") var score_type: String = "Left"

func on_score_change():
    update_display()

func _ready() -> void:
    update_display()

func update_display() -> void:
    match score_type:
        "Left":
            text = str(Global.left_score)
        "Right":
            text = str(Global.right_score)
