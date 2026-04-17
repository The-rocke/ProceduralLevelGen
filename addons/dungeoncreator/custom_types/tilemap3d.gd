class_name Tilemap3D
extends Node3D

# SIDE TILES
@export var north_side: PackedScene
@export var south_side: PackedScene
@export var east_side: PackedScene
@export var west_side: PackedScene

# CORNER TILES
@export var northwest_corner: PackedScene
@export var northeast_corner: PackedScene
@export var southwest_corner: PackedScene
@export var southeast_corner: PackedScene

# NARROW TILES
@export var north_south_straight: PackedScene
@export var east_west_straight: PackedScene

# DEAD END TILES
@export var north_deadend: PackedScene
@export var south_deadend: PackedScene
@export var east_deadend: PackedScene
@export var west_deadend: PackedScene

@export var centre: PackedScene
@export var enclosed: PackedScene
