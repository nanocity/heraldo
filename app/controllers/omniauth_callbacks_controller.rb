class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :load_oauth, except: :destroy

  def github
    manage_oauth
  end

  def google_oauth2
    manage_oauth
  end

  def twitter
    manage_oauth
  end

  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield resource if block_given?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end

  private
    def load_oauth
      @oauth = request.env['omniauth.auth']
    end

    def manage_oauth
      identity = Identity.find_or_create_by_oauth( @oauth )

      unless identity.user
        identity.user = current_user || User.find_or_create_by_oauth( @oauth.info )
        identity.save
      end

      sign_in( resource_name, identity.user )
      redirect_to( after_omniauth_sign_in_path_for( resource ) )
    end

    def after_omniauth_sign_in_path_for( resource )
      dashboard_path
    end
end
