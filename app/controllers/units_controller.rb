class UnitsController < ApplicationController

  respond_to :html, :js, :json

  before_action :authenticate_user!

  def index
    @units = Unit.all
    @user = current_user
    @unit_user = UnitUser.new
  end

  def create
    unit = Unit.new(unit_params)
    unit.position = "0x0"
    unit.state = "active"
    unit.unit_pic = "https://placekitten.com/g/200/150" #unless unit.unit_pic.length > 0
    unit.save
    redirect_to action: "index"
  end

  def edit
  end

  def show
    @unit = Unit.find(params[:id])
    render json: @unit, location: @unit
  end

  def new
    render :layout => "devise"
  end

  def update
    @unit = Unit.find(params[:id])

    respond_to do |format|

      format.html do
        logger.info("---------------------format.html--- params is " + params.to_s)

        if params['position'] && @unit.update({ position: params['position'] })
          respond_with(@unit.to_json)
        end

        if params['state'] && @unit.update({ state: params['state'], user_disabler: params['user_disabler'] })
          # @unit.update({ :note => '' }) if @unit.state == "active"
          respond_with(@unit.to_json)
        end
      end

      if params['unit']['notes'] && @unit.update({ notes: params['unit']['notes'] })
        format.json {respond_with_bip(@unit) }
      end

      format.json do
        logger.info("---------------------format.json--- params is " + params.to_s)
        @unit.update(unit_params)
        if @unit.state == "disabled"
          @unit.update({ :when_disabled => Time.now })
        elsif @unit.state == "active"
          @unit.update({ :when_disabled => nil })
        else
          raise "unknown unit state"
        end
        render json: @unit
      end

    end

  end



  def destroy
    @unit = Unit.find(params[:id])
    if @unit.destroy
      flash[:message] = "unit deleted"
    else
      flash[:error] = "unit not removed"
    end


  end

  def report_status
      unit = Unit.find(params[:id])
      data = unit.report_status

      respond_with(data)
  end

  # called in application.html.erb on pageload
  def report_unit_statuses
    u_times = Unit.all.map do |u|
      { :id => u.id, :state => u.state, :duration => u.duration, :time_available => u.time_available }
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.js { respond_with(u_times) }
    end
  end

  def unit_statuses
    @units = Unit.all
    @units = Unit.includes(:unit_users)
    render json: @units
    #respond_with @units
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :screen_name, :unit_pic, :unit_pic_cache, :notes, :contact_flags, :state, :user_disabler )
  end

end
