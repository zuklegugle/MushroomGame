class_name PlayerInputAction extends Node

export(String) var action_name

signal started(action)
signal performed(action)
signal canceled(action)

var started = false
var performed = false
var canceled = false
