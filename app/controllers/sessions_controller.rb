class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by(facebook_id: auth['uid']) do |u|
      u.first_name =  auth['info']['name'].split(" ").first
      u.last_name =  auth['info']['name'].split(" ").last
      u.email = auth['info']['email']

      u.password = SecureRandom.hex
    end
    session[:user_id] = @user.id

    redirect_to user_path(@user)
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
