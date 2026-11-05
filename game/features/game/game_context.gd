class_name GameContext extends Node3D


signal menu_requested

@export var map_context_scene: PackedScene
@export var mission_context_scene: PackedScene
@export var explorer_context_scene: PackedScene


@onready var menu_button: Button = %menu
@onready var map_button: Button = %map_button
@onready var mission_button: Button = %mission_button
@onready var explorer_button: Button = %explore_button


var _current_context: Node
var _game_state: GameState


func build() -> void:
	_game_state = GameState.new()
	_game_state.money = 50
	pass

func bind_dependences() -> void:
	print("bind")

	pass

func setup() -> void:
	print("setup")
	menu_button.pressed.connect(menu_requested.emit)
	map_button.pressed.connect(mount_map)
	mission_button.pressed.connect(mount_mission)
	explorer_button.pressed.connect(mount_explorer)
	
	mount_map()
	
	
	
func mount_map() -> void:
	if _current_context:
		_current_context.queue_free()
	
	_current_context = map_context_scene.instantiate()
	var context: MapContext = _current_context as MapContext
	if not context:
		printerr("No map context found")
		return
		
	add_child(context)
	context.build()
	context.bind_dependences(_game_state)
	context.setup()
	

func mount_mission() -> void:
	if _current_context:
		_current_context.queue_free()
	
	_current_context = mission_context_scene.instantiate()
	var context: MissionContext = _current_context as MissionContext
	if not context:
		printerr("No mission context found")
		return
		
	add_child(context)
	context.build()
	context.bind_dependences()
	context.setup()
	
func mount_explorer() -> void:
	if _current_context:
		_current_context.queue_free()
	
	_current_context = explorer_context_scene.instantiate()
	var context: ExplorerContext = _current_context as ExplorerContext
	if not context:
		printerr("No explorer context found")
		return
		
	add_child(context)
	context.build()
	context.bind_dependences()
	context.setup()
