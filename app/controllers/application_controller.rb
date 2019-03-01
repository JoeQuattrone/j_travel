class ApplicationController < ActionController::Base
  def logged_in?(user)
    session[:user_id] == user.id
  end

  def set_user
    if self.session[:user_id]
      @user = User.find_by(id: self.session[:user_id])
    end
  end
end
