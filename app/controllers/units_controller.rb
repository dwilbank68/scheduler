class UnitsController < ApplicationController

  respond_to :html, :json

  before_action :authenticate_user!

  def index
    @units = Unit.all
    # @user = User.last #until current_user arrives with Devise
    @user = current_user #until current_user arrives with Devise
    @unit_user = UnitUser.new
  end

  def create

  end

  def edit
  end

  def new
  end

  def update
  end


  # what goes here to stop rails from trying to find a template?
  def report_status
      unit = Unit.find(params[:id])
      if unit.duration == 0
        # data = Time.now
        data = { :time_available => Time.now, :duration => 0 }
      else
        # data = unit.time_available
        min = unit.duration
        uu_times = unit.unit_users.map do |uu|
          { :id => uu.id, :start_time_formatted => uu.start_time_formatted, :end_time_formatted => uu.end_time_formatted, :duration => uu.duration, :note => uu.note }
        end
        data = { :time_available => unit.time_available,
                 :duration => min,
                 :duration_string => "<span>#{min / 60}</span><span class='smaller relative raised'>hrs</span> <span>#{min % 60}</span><span class='smaller relative raised'>min</span>",
                 # :uu_queue => unit.unit_users.to_json(:only => [:id, :start_time_formatted, :duration, :end_time_formatted, :note])
                 :uu_queue => uu_times.to_json
        }
      end
      puts "*"*30
      puts "data in 'report_status' is " + data.to_s
      puts "*"*30
      respond_with(data)
  end

  # called in application.html.erb on pageload
  def report_unit_statuses
    # data = Unit.pluck(:id, :duration, :time_available)

    u_times = Unit.all.map do |u|
      { :id => u.id, :state => u.state, :duration => u.duration, :time_available => u.time_available }
    end

    respond_to do |format|
      format.html { render nothing: true }
      format.js { respond_with(u_times) }
    end

    # data = Unit.pluck(:id, :duration, :time_available)
    # respond_with(data)
  end

  private ########################



end
