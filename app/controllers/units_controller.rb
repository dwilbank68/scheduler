class UnitsController < ApplicationController
  def index
    @units = Unit.all
    @user = User.first
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
end
