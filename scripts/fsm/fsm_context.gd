class_name FsmContext



var context_memory: Dictionary = {}


func get_value_bool(key_name: String, default_value: bool = false) -> bool:
	return context_memory.get(key_name, default_value)
