class ApplicationController < ActionController::Base

  protect_from_forgery
  layout                  :set_default_layout
  respond_to              :json


  # Get the current logged user
  def current_user
    @current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])
  end


  private

    def set_default_layout
      if request.xhr?
        'ajax'
      else
        'application'
      end
    end

end
