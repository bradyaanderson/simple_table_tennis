extends Node

var left_score: int = 0
var right_score: int = 0

func _ready():
   _connect_score_signals()

func _on_left_score():
   left_score += 1

func _on_right_score():
   right_score += 1

func _connect_score_signals() -> void:
   var main_scene = get_tree().get_root().get_node("Main")
   if main_scene:
       main_scene.connect("left_score", Callable(self, "_on_left_score"))
       main_scene.connect("right_score", Callable(self, "_on_right_score"))
