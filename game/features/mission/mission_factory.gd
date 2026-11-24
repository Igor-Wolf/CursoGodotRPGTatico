class_name MissionFactory extends Node


func generate_random(mission_params: MissionsParameters) -> MissionData:
	#Do the logic to create a mission data for us and return it
	var mission = MissionData.new()
	mission.name= mission_params.possibleNames.pick_random()
	mission.description = mission_params.possibleDescriptions.pick_random()
	return mission
