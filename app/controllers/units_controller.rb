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

  def report_status

    # if request.xhr?

      unit = Unit.find(params[:id])
      if unit.duration == 0
        respond_with(Time.now)
      else
        respond_with(unit.time_available)
      end

    # end

  end

  private ########################



end
