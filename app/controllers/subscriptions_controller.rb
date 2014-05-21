class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @subscription = Subscription.new( params[:subscription].merge( status: :pending ) )
    @subscription.create_army
    @subscription.user = current_user
    @subscription.save

    respond_with @subscription, location: tournament_path( @subscription.tournament )
  end

  def destroy
    @subscription.destroy

    respond_with @subscription, location: tournament_path( @subscription.tournament )
  end
end
