class SessionsController < ApplicationController

  def new
    @user = User.new
  end


  def create
    user = User.authenticate(params[:username], params[:password])

    if user
      session[:current_user_id] = user.id
      render text: 'ok!'
    else
      @user = User.new(username: params[:username], password: params[:password])
      @user.errors.add(:username, I18n.t('errors.login_failed'))
      render action: :new
    end
  end

end
