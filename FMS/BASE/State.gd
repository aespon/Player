extends Node2D
class_name State


@onready var enemy  = owner                                                           
@onready var player = get_tree().get_nodes_in_group("Player")[0]
var last_raycast : int

#estas variables estan presente en todos los estados que extiendan state

############$".."#########################
# This is the base enemy state
# Each state will inherit from this
#####################################

signal transitioned(state: State, new_state_name: String)


# This is called directly when transitioning to this state
# Useful for setting up the state to be used
# In Idle, we use this function to decide how long we will idle for
func enter():
	pass


# When the state is active, this is essentially the _process() function
func process_state(_delta: float):
	pass


# When the state is active, this is essentially the _physics_process() function
func physics_process_state(_delta: float):
	pass


# Useful for cleaning up the state
# For example, clearing any timers, disconnecting any signals, etc.
func exit():
	pass


