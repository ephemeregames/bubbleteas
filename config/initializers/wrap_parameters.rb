# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

# Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
end


# http://apidock.com/rails/ActiveRecord/Serialization/to_json
# Disable root element in JSON by default.
#
# konata = User.find(1)
#  ActiveRecord::Base.include_root_in_json = true
#  konata.to_json
#  # => { "user": {"id": 1, "name": "Konata Izumi", "age": 16,
#                  "created_at": "2006/08/01", "awesome": true} }
#
#  ActiveRecord::Base.include_root_in_json = false
#  konata.to_json
#  # => {"id": 1, "name": "Konata Izumi", "age": 16,
#        "created_at": "2006/08/01", "awesome": true}
#
ActiveSupport.on_load(:active_record) do
  self.include_root_in_json = false
end
