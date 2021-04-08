class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) 
      redirect_to root_path 
    else
      binding.pry
      redirect_to user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :birth_day, :password, :password_confirmation) 
  end

end
