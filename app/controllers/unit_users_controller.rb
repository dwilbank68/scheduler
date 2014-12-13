class UnitUsersController < ApplicationController

  before_action :find_unit
  before_action :find_user
  # before_action :authenticate_user!

  def index
  end

  def create
    uu = UnitUser.new(user_id:@user.id, unit_id:@unit.id)
    uu.start_time = params[:unit_user][:start_time]
    uu.duration = params[:unit_user][:duration]
    uu.note = params[:unit_user][:note]
    if uu.save
      redirect_to :back
    else

    end
  end

  def edit
  end

  def new
  end

  def update
  end

  ##################################
  private
  ##################################

  def find_unit
    @unit = Unit.find(params[:unit_id])
  end

  def find_user
    @user = User.find(params[:unit_user][:user_id].to_i)
  end

  def unit_user_params
    params.require(:user).permit(:name, :phone, :SMS, :email, :start_time, :duration, :note)
  end

end
