class UsersController < ApplicationController

  # before_action :authenticate_user!
  before_action :get_unit, except: [:index, :create, :edit, :new, :update, :show]
  before_action :get_user

  def index
    @users = User.all
  end

  def create

  end

  def edit

  end

  def show

  end

  def new
  end

  def update

    if current_user.update(user_params)
      flash[:notice] = "User information updated"
      redirect_to units_path
    else
      render "edit_user_path"
    end

  end
end

private

def user_params
    params.require(:user).permit(:name, :email, :email2, :phone, :phone2, :timezone, :avatar, :avatar_cache, :contact_flags )
end

def get_user
  @user = User.find(params[:id])
end

def get_unit
  params[:unit_id]
end