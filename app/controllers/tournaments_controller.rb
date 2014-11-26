class TournamentsController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]

  load_and_authorize_resource

  def index
    respond_with @tournaments
  end

  def show
    respond_with @tournament
  end

  def management
    respond_with @tournament
  end

  def new
  end

  def create
    @tournament = Tournament.new( create_params )
    @tournament.user = current_user
    @tournament.save

    respond_with @tournament
  end

  def edit
  end

  def update
    @tournament.update_attributes( update_params )

    respond_with @tournament
  end

  def destroy
    @tournament.destroy

    respond_with @tournament
  end

  private

  def create_params
    params.require( :tournament ).permit( :title,:date,:sign_up_date,:address,:max_users,:user )
  end

  def update_params
    params.require( :tournament ).permit( :title,:date,:sign_up_date,:address,:max_users )
  end
end
