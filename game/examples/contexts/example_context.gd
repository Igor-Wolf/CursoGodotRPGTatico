class_name ExampleContext extends Node


enum ExampleSubContexts{
	
	ContextOne,
	ContextTwo
}


var current_subcontext: ExampleSubContexts
var current_subcontext_node: Node

@export var subcontext_one_scene: PackedScene

var coll_integer: int = 34

func build() -> void:
	#Build any services or other variables that we need in this context
	pass
	

func bind_dependences() -> void:
	# Pass in the bind any depencecies that this context needs from parent
	pass
	
func setup() -> void:
	# At this point, we have all dependencies resolved, and we can do any
	# setup that requires those, like connect signals and use factories etc...
	pass
	
	
func mount_context_one() -> void:
	
	# Tear down old subcontext
	if current_subcontext_node:
		current_subcontext_node.queue_free()
		
		# You may need to do other tear down stepps for your context depending on what it does
	
	# Buld new subcontext
	current_subcontext = ExampleSubContexts.ContextOne
	current_subcontext_node = subcontext_one_scene.instantiate()
	add_child(current_subcontext_node)
	
	var subcontext_one : ExampleSubContextOne = current_subcontext_node as ExampleSubContextOne
	if subcontext_one == null:
		printerr("Missing subcontext")
		return
		
	subcontext_one.build()
	subcontext_one.bind_dependences(coll_integer)
	subcontext_one.setup()	
	
	
	
	
	
	
