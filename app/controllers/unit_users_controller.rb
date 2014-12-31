class UnitUsersController < ApplicationController
  respond_to :html, :js

  before_action :find_user, except: [:edit, :update, :destroy]
  before_action :find_unituser, only: [:update, :destroy]
  # before_action :authenticate_user!



  def index
  end

  def create
    @unit = Unit.find(params[:unit_id])
    @uu = UnitUser.new(user_id:@user.id, unit_id:@unit.id)
    # @uu.start_time = params[:unit_user][:start_time] - will be Time.now()
    @uu.duration = params[:unit_user][:duration]
    @uu.note = params[:unit_user][:note]

    respond_with(@uu)


  end

  def update
    @unit = Unit.find(params[:unit_id])

    respond_to do |format|
      if @unituser.update(unit_user_params)
        # format.html { redirect_to(:back, :notice => 'User was successfully updated.') }
        format.json {respond_with_bip(@unituser) }
      else
        # format.html { render :action => 'edit' }
        format.json { respond_with_bip(@unituser) }
      end
    end
  end

  def destroy

    if @unituser.destroy
      flash[:notice] = "unit user removed"
    else
      flash[:error] = "unit user not removed"
    end

    respond_with(@unituser) do |format|
      format.html { redirect_to @units }
    end

  end


  ##################################
  private
  ##################################

  def find_unituser
    @unituser = UnitUser.find(params[:id])
  end

  def find_user
    # @user = User.find(params[:unit_user][:user_id].to_i)
    @user = User.last # until current_user is available from Devise
  end

  def unit_user_params
    params.require(:unit_user).permit(:duration, :duration, :note, :id, :unit_id, :user_id)
  end



end
