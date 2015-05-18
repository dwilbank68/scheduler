class UnitUsersController < ApplicationController
  respond_to :html, :js

  before_action :find_user, except: [:edit, :update]
  before_action :find_unituser, only: [:update, :destroy, :show, :update_duration]

  def create
    @unit = Unit.find(params[:unit_id])
    @units = Unit.all
    @uu = UnitUser.new(user_id:@user.id, unit_id:@unit.id)
    @uu.duration = params[:unit_user][:duration]
    @uu.duration = 5 if @uu.duration == 0
    # @uu.note = params[:unit_user][:note] == '' ? 'click to edit' : params[:unit_user][:note]
    @uu.note = params[:unit_user][:note] if params[:unit_user][:note]
    @uu.save
    if @unit.unit_users.count == 1
      @uu.start_time = Time.now
    else
      queue = @unit.unit_users
      previous_uu = queue[queue.index(@uu) - 1]
      @uu.start_time = previous_uu.end_time
    end
    @uu.end_time = @uu.start_time + @uu.duration.minutes
    @uu.save

    respond_with(@uu) do |format|
        format.html { redirect_to @units }
    end

  end

  def show

  end

  def destroy
    @unit = @unituser.unit
    ex_unituser = @unituser
    idx_of_deleted = @unit.unit_users.index(@unituser)
    deleted_unitusers_name = @unituser.user.name
    if @unituser.destroy
      @unit.reload
      queue_after_deletion = @unit.unit_users
      queue_after_deletion.each_with_index do |unituser, idx|
        if idx >= idx_of_deleted
           if unituser == unituser.unit.unit_users.first
               unituser.start_time = Time.now
               unituser.end_time = unituser.start_time + (unituser.duration * 60)
           else
              unituser.start_time = queue_after_deletion[idx-1].end_time
              unituser.end_time = unituser.start_time + (unituser.duration * 60)
           end
          unituser.save
          message = "#{deleted_unitusers_name} has left the queue. Your new start time is #{unituser.start_time_formatted}"
          send_notifications(unituser,message)
        end
      end
    else
       flash[:error] = "unit user not removed"
    end

    head 204
  end

  def update_duration
    dur_minutes = params[:minutes].to_i
    end_time = @unituser.start_time + dur_minutes.minutes

    if Time.current > end_time
      render json: { duration_hrs_min: "too short" }
      return
    end

    if @unituser.update({ :duration => dur_minutes, :end_time => end_time })
      render json: {duration_hrs_min: @unituser.duration_hrs_min}
    end

    # update the start/end times of the rest of the queue,
    # meaning to only change those who are LATER in the queue
    @unit = @unituser.unit
    idx_of_updated = @unit.unit_users.index(@unituser)
    queue_after_update = @unit.unit_users
    queue_after_update.each_with_index do |unituser, idx|
      if idx >= idx_of_updated
        if unituser == unituser.unit.unit_users.first
          unituser.end_time = unituser.start_time + unituser.duration * 60
        else
          unituser.start_time = queue_after_update[idx-1].end_time
          unituser.end_time = unituser.start_time + unituser.duration * 60
        end
        unituser.save
      end
    end
    @unit.update({ :time_available => queue_after_update.last.end_time })
  end

  def update_note
    @unituser = UnitUser.find(params[:id])
    note = params[:note]
    render json: @unituser if @unituser.update({ :note => note })
  end

  private

  # sends email & text (Sendgrid & Twilio)
  def send_notifications(unituser, msg)
    user = unituser.user
    user.send_sms(msg)
    UserMailer.send_email(user, user.email,  msg).deliver if user.contact_flags[1] == "1"
    UserMailer.send_email(user, user.email2, msg).deliver if user.contact_flags[3] == "1"
  end

  def find_unituser
    @unituser = UnitUser.find(params[:id])
  end

  def find_user
    @user = current_user
  end

  def unit_user_params
    params.require(:unit_user).permit(:duration, :note, :id, :unit_id, :user_id)
  end

end
