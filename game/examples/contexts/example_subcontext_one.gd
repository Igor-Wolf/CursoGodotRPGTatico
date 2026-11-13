class_name ExampleSubContextOne extends Node

var cool_int: int

func build() -> void:
	#Build any services or other variables that we need in this context
	pass
	

func bind_dependences(_cool_int: int) -> void:
	# Pass in the bind any depencecies that this context needs from parent
	
	cool_int = _cool_int
	pass
	
func setup() -> void:
	# At this point, we have all dependencies resolved, and we can do any
	# setup that requires those, like connect signals and use factories etc...
	pass
	
	
