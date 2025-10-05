extends Node2D
class_name BottledShipParticleController


@export var glass_particles: GPUParticles2D
@export var wood_particles: GPUParticles2D


func trigger_particles() -> void:
	glass_particles.emitting = true
	wood_particles.emitting = true
