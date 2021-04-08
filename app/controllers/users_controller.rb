class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params) 
      redirect_to root_path 
    else
      redirect_to "show"
    end
  end

end
