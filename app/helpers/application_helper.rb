module ApplicationHelper

  # Check if the a controller (or a list of controllers) are currently used
  def in_controller?(*controllers)
    controllers.flatten.map(&:to_s).include?(controller_name)
  end

end
