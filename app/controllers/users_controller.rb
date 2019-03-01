class UsersController < ApplicationController

  def index
    render :layout => "application"
    @hotel = Hotel.new
    @user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def new
    #render :layout => false
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def signin

  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "Invalid email or password"
      render 'signin'
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

  def show
    @user = User.find_by(id: params[:id])
    if logged_in?(@user)
      render 'show'
    else
      redirect_to root_path
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    redirect_to root_path if !logged_in?(@user)
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    flash[:message] = "Account successfully updated!"
    redirect_to user_path(@user)
  end

  def destroy
    session.clear
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end


end
