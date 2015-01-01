class UsersController < ApplicationController

  # before_action :authenticate_user!
  before_action get_unit

  def index
    @users = User.all
  end

  def create
    if @unit
      Unit.
    else
    end
  end

  def edit
  end

  def new
  end

  def update
  end
end


def get_unit
  params[:unit_id]
end