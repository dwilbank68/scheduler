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
    unit = Unit.find(params[:id])
    if unit.update({ position: params[:_json] })
      logger.info('-----------------------------------------------------------------')
      logger.info('incoming params to Units#update are ' + params.to_s )
      logger.info('unit position is ' + unit.position.to_s )
      logger.info('-----------------------------------------------------------------')
      respond_with(unit.to_json)
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    if @unit.destroy

    else
      flash[:error] = "unit not removed"
    end
    #
    # respond_with(@unit) do |format|
    #   format.html { redirect_to @units }
    # end

  end

  # what goes here to stop rails from trying to find a template?
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
    params.require(:unit).permit(:name, :screen_name, :unit_pic, :unit_pic_cache )
  end

end
