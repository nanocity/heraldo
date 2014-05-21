class ArmiesController < ApplicationController
  load_and_authorize_resource

  def update
    @army.update_attributes( params[:army] )

    respond_with @army, location: request.referer
  end
end
