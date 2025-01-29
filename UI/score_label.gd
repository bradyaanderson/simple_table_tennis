extends Label

@export var score_side: Global.Side

func on_score_change():
    update_display()

func _ready() -> void:
    update_display()

func update_display() -> void:
    match score_side:
        Global.Side.LEFT:
            text = str(Global.score[Global.Side.LEFT])
        Global.Side.RIGHT:
            text = str(Global.score[Global.Side.RIGHT])
