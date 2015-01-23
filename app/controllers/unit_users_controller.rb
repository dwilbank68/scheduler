class UnitUsersController < ApplicationController
  respond_to :html, :js

  before_action :find_user, except: [:edit, :update]
  before_action :find_unituser, only: [:update, :destroy]
  # before_action :authenticate_user!

  def create
    @unit = Unit.find(params[:unit_id])
    @uu = UnitUser.new(user_id:@user.id, unit_id:@unit.id)
    @uu.duration = params[:unit_user][:duration]
    @uu.note = params[:unit_user][:note]
    @uu.save
    if @uu == @unit.unit_users.first
      @uu.start_time = Time.now
    else
      queue = @unit.unit_users
      previous_uu = queue[queue.index(@uu) - 1]
      @uu.start_time = previous_uu.end_time
    end
    @uu.end_time = @uu.start_time + @uu.duration.minutes
    @uu.save
    respond_with(@uu)
  end

  def update
    @unit = @unituser.unit

    respond_to do |format|
      if @unituser.update(unit_user_params)
        # update end_time
        @unituser.end_time = @unituser.start_time + @unituser.duration.minutes
        @unituser.save

        # update the start/end times of the rest of the queue,
        # meaning to only change those who are LATER in the queue
        idx_of_updated = @unit.unit_users.index(@unituser)
        queue_after_update = @unit.unit_users
        queue_after_update.each_with_index do |unituser, idx|
          if idx >= idx_of_updated
            if unituser == unituser.unit.unit_users.first
              unituser.end_time = unituser.start_time + unituser.duration * 60
            else
              logger.info('----------------- ' + unituser.id.to_s + ' will be set based on ' + queue_after_update[idx-1].id.to_s)# the previous element id
              unituser.start_time = queue_after_update[idx-1].end_time
              unituser.end_time = unituser.start_time + unituser.duration * 60
            end
            unituser.save
          end
        end

        # format.json {respond_with_bip(@unituser) } # got rid of this and mimicked the functionality in the ajax callback
        format.json { render :json => {:unit_duration => @unit.duration_hrs_min,
                                       :unit_user_duration => @unituser.duration_hrs_min,
                                       # :unit_user_end => @unituser.end_time.in_time_zone(@unituser.user.timezone).strftime('%b %e, %l:%M %p'),
                                       :unit_user_end => @unituser.end_time_formatted,
                                       :unit_user_queue => @unit.unit_users_time_formatted }
        }
      else
        # format.html { render :action => 'edit' }
        format.json { respond_with_bip(@unituser) }
      end
    end
  end

  def destroy

    @unit = @unituser.unit
    idx_of_deleted = @unit.unit_users.index(@unituser)

    if @unituser.destroy
      # @unituser.destroy
      @unit.reload
      #logger.info('idx of deleted el, queue.length is ' + idx_of_deleted.to_s + ', ' + queue.length.to_s)
       queue_after_deletion = @unit.unit_users
       elements_to_update = queue_after_deletion[idx_of_deleted..-1]
       # logger.info('-----------------------------------------------------------------')
       # logger.info(elements_to_update.inspect)
       # logger.info('-----------------------------------------------------------------')



      queue_after_deletion.each_with_index do |unituser, idx|
        if idx >= idx_of_deleted
           if unituser == unituser.unit.unit_users.first
             logger.info('----------------- ' + unituser.id.to_s + ' will be set to Time.now')# the element id
               unituser.start_time = Time.now
               unituser.end_time = unituser.start_time + unituser.duration * 60
           else
             logger.info('----------------- ' + unituser.id.to_s + ' will be set based on ' + queue_after_deletion[idx-1].id.to_s)# the previous element id
              unituser.start_time = queue_after_deletion[idx-1].end_time
              unituser.end_time = unituser.start_time + unituser.duration * 60
           end
          unituser.save
        end

      end

    else
       flash[:error] = "unit user not removed"
    end


    respond_with(@unituser) do |format|
      format.html { redirect_to @units }
    end

  end


# - - - - - - - - -
  private


  def find_unituser
    @unituser = UnitUser.find(params[:id])
  end

  def find_user
    # @user = User.find(params[:unit_user][:user_id].to_i)
    # @user = User.last # until current_user is available from Devise
    @user = current_user
  end

  def unit_user_params
    params.require(:unit_user).permit(:duration, :duration, :note, :id, :unit_id, :user_id)
  end



end
