class_name MainMenuContext extends Node3D

signal start_game_requested
@onready var start_game_button: Button = %start_game

func build() -> void:
	print("build")
	pass

func bind_dependences() -> void:
	print("bind")

	pass

func setup() -> void:
	print("setup")
	start_game_button.pressed.connect(start_game_requested.emit)
	pass
