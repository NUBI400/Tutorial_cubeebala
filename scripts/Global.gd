extends Node

var criacao_no_pai = null
var player = null

var correr = false

var pontos = 0 

var recorde = 0

var camera = null

func instantiate_node(node, location, parent):
	var node_instantiate = node.instantiate()
	parent.add_child(node_instantiate)
	node_instantiate.global_position = location
	return node_instantiate
