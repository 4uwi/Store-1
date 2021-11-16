class AdminsController < ApplicationController

  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to '/'
      end
  end

  def edit
    if current_user.admin?
      @user = User.find_by id: params[:id]
      if @user.admin?
        @user.update admin:false
        flash[:notice] = "Revoked #{@user.first_name} admin!"
      else
        @user.update admin:true
        flash[:notice] = "Maked #{@user.first_name} admin!"
      end
      redirect_to admins_path
    else
      redirect_to '/'
    end
  end
end