extends CharacterBody3D

@export var speed = 5
@export var detectionRadius = 10.0

@onready var navigation_agent_3d = $NavigationAgent3D
@onready var character = $"../character"

func _physics_process(delta: float) -> void:
	var player = find_player() # Função para encontrar o jogador
	
	if player and global_transform.origin.distance_to(player.global_transform.origin) <= detectionRadius:
		navigation_agent_3d.target_position = player.global_transform.origin
		
		var current_location = global_transform.origin
		var next = navigation_agent_3d.get_next_path_position()
		var new_velocity = (next - current_location).normalized() * speed
		
		velocity = new_velocity
		move_and_slide()

func find_player() -> Node:
	# Lógica para encontrar o jogador (por exemplo, procurar por um nó chamado "Player")
	return get_node("../character")
