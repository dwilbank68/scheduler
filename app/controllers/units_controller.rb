class UnitsController < ApplicationController

  before_action :authenticate_user!

  def index
    @units = Unit.all
    @user = User.last #until current_user arrives with Devise
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

  private ########################



end
