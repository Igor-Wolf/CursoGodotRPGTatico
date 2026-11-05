class_name MapContext extends Node3D

var _game_state: GameState

func build() -> void:
	pass

func bind_dependences(game_state: GameState) -> void:
	_game_state = game_state

	

func setup() -> void:
	print(_game_state.money)
	
	
