class_name ResourceUtils

static func get_resource_name(resource: Resource):
	return resource.resource_path.get_file().trim_suffix('.tres')
