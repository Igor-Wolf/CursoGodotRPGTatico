class_name GameContext extends Node3D


signal menu_requested

@export var map_context_scene: PackedScene
@export var mission_context_scene: PackedScene
@export var explorer_context_scene: PackedScene

#Temporary
@export var mission_params: MissionsParameters


@onready var menu_button: Button = %menu
@onready var map_button: Button = %map_button
@onready var mission_button: Button = %mission_button
@onready var explorer_button: Button = %explore_button



var _current_context: Node
var _game_state: GameState
var _mission_factory: MissionFactory


func build() -> void:
	_game_state = GameState.new()
	_mission_factory = MissionFactory.new()
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
	
	initialize_game_state()
	
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
	
	context.mission_requeested.connect(handle_transition_to_mission)
	

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

func initialize_game_state() -> void:
	_game_state.available_missions = []
	
	for i: int in range(0,4):
		_game_state.available_missions.append(_mission_factory.generate_random(mission_params))

	_game_state.available_missions_changed.emit(_game_state.available_missions)
	
func handle_transition_to_mission(mission: MissionData) -> void:
	_game_state.current_mission= mission
	mount_mission()
