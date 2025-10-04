# UUID.gd
class_name UUID

static func v4() -> String:
	var rng := RandomNumberGenerator.new()
	var b := PackedByteArray()
	b.resize(16)
	for i in 16:
		b[i] = rng.randi() & 0xFF
	# RFC 4122: set version (0100) and variant (10)
	b[6] = (b[6] & 0x0F) | 0x40
	b[8] = (b[8] & 0x3F) | 0x80
	var hex := b.hex_encode()  # 32 hex chars
	return "%s-%s-%s-%s-%s" % [
		hex.substr(0, 8),
		hex.substr(8, 4),
		hex.substr(12, 4),
		hex.substr(16, 4),
		hex.substr(20, 12),
	]
