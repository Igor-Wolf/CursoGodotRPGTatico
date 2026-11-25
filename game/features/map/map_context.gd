class_name MapContext extends Node3D

signal selected_mission_updated
signal mission_requeested(mission: MissionData)

@onready var _ui_mission_list_panel: MissionListPanel =%mission_list_panel
@onready var _ui_mission_detail_panel: MissionDetailPanel = %mission_detail_panel
@onready var _map_camera: MapCamera = %map_camera

var _game_state: GameState

# Ui State
var _selected_mission: MissionData
var selected_mission: MissionData:
	get: return _selected_mission
	set(value):
		if (value == _selected_mission):
			return
		_selected_mission = value
		selected_mission_updated.emit(value)
		_map_camera.focus_mission = selected_mission

func build() -> void:
	pass

func bind_dependences(game_state: GameState) -> void:
	_game_state = game_state

	

func setup() -> void:
	
	_game_state.available_missions_changed.connect(_ui_mission_list_panel.populate_missions)
	_ui_mission_list_panel.populate_missions(_game_state.available_missions)
	_ui_mission_list_panel.mission_selection_requested.connect(func (mission: MissionData) -> void: selected_mission = mission )
	selected_mission_updated.connect(func (mission: MissionData) -> void: _ui_mission_detail_panel.current_mission= mission)

	_ui_mission_detail_panel.cancelled.connect(handle_detail_candelled)
	
	_ui_mission_detail_panel.current_mission = null
	_ui_mission_detail_panel.enter_request.connect(handle_enter_requested)
	
	
	_ui_mission_detail_panel.hide()	
	_ui_mission_list_panel.get_focus(null)
	
	
	
func handle_detail_candelled() -> void:
	_ui_mission_list_panel.get_focus(selected_mission)
	selected_mission = null
	
	
	
func handle_enter_requested() -> void:
	await _map_camera.animate_focus_in()
	mission_requeested.emit(selected_mission)
