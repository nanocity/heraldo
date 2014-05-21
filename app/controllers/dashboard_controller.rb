class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tournaments = current_user.tournaments
    @subscriptions = current_user.subscriptions
  end
end
