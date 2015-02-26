class UnitsController < ApplicationController

  respond_to :html, :js, :json

  before_action :authenticate_user!

  def index
    @units = Unit.all
    # @user = User.last #until current_user arrives with Devise
    @user = current_user #until current_user arrives with Devise
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

  def new
    render :layout => "devise"
  end

  def update
    @unit = Unit.find(params[:id])

    respond_to do |format|

      format.html do
        if params['position'] && @unit.update({ position: params['position'] })
          respond_with(@unit.to_json)
        end

        if params['state'] && @unit.update({ state: params['state'], user_disabler: params['user_disabler'] })
          logger.info('--------------------------------- unit state is changing')
          @unit.update({ :note => '' }) if @unit.state == "active"
          @unit.update({ :when_disabled => Time.now }) if @unit.state == "disabled"
          respond_with(@unit.to_json)
        end
      end

      if params['unit']['note'] && @unit.update({ note: params['unit']['note'] })
        format.json {respond_with_bip(@unit) }
      end

      if params['unit']['notes'] && @unit.update({ notes: params['unit']['notes'] })
        format.json {respond_with_bip(@unit) }
      end

    end

  end

  def destroy
    @unit = Unit.find(params[:id])
    if @unit.destroy

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

  private ########################

  def unit_params
    params.require(:unit).permit(:name, :screen_name, :unit_pic, :unit_pic_cache, :notes, :contact_flags )
  end

end
