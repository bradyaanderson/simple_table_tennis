extends Node

enum Side {LEFT, RIGHT}

var score = {Side.LEFT: 0, Side.RIGHT: 0}

func _ready():
   _connect_score_signals()

func _on_score(side: Side) -> void:
   score[side] += 1

func _connect_score_signals() -> void:
   var main_scene = get_tree().get_root().get_node("Main")
   if main_scene:
       main_scene.connect("score", Callable(self, "_on_score"))
