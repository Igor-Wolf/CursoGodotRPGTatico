class_name RootContext extends Node3D


var _current_context: Node

var _music_player: AudioStreamPlayer

func _ready() -> void:
	build()
	bind_dependences()
	setup()


@export var main_menu_scene: PackedScene
@export var game_context_scene: PackedScene

@export var temporary_sample_music_track: AudioStream

func build() -> void:
	_music_player = AudioStreamPlayer.new()
	_music_player.autoplay= true
	_music_player.stream = temporary_sample_music_track
	add_child(_music_player)
	pass

func bind_dependences() -> void:
	print("bind")

	pass

func setup() -> void:
	mount_main_menu()

	pass

func mount_main_menu() -> void:
	if _current_context:
		_current_context.queue_free()
	
	_current_context = main_menu_scene.instantiate()
	var menu_context: MainMenuContext = _current_context as MainMenuContext
	if not menu_context:
		printerr("No menu context found")
		return
		
	add_child(menu_context)
	menu_context.build()
	menu_context.bind_dependences(_music_player)
	menu_context.setup()
	
	menu_context.start_game_requested.connect(mount_game)
	
	
func mount_game() -> void:
	if _current_context:
		_current_context.queue_free()
	
	_current_context = game_context_scene.instantiate()
	var game_context: GameContext = _current_context as GameContext
	if not game_context:
		printerr("No game context found")
		return
		
	add_child(game_context)
	game_context.build()
	game_context.bind_dependences()
	game_context.setup()
	
	game_context.menu_requested.connect(mount_main_menu)
	
