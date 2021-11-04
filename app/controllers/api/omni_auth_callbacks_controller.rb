class Api::OmniAuthCallbacksController < DeviseTokenAuth::ApplicationController

  def omniauth_success
    all 
    if end_user?
      render_data_or_redirect('authFailure', {error: 'User is not authorized'})
    else   
      get_resource_from_auth_hash
      set_token_on_resource
      create_auth_params
      bypass_sign_in(@resource)
      @resource.save!
      yield @resource if block_given?

      render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
    end
  end
  def omniauth_failure
    @error = params[:message]
    render_data_or_redirect('authFailure', {error: @error})
  end

  private

  def end_user?
    false
    # user = resource_class.where( 
    #   uid: auth_hash['uid'],
    #   provider: auth_hash['provider']
    # ).first
    # user.nil? || user.role == 'end_user'
  end

  def all
    # request.env['omniauth.auth']
    @user = User.from_omniauth(User.last)
    params = User.last
    # I18n.locale = params["locale"]
    if @user.persisted?
      # We need this in order to be able to overwrite the default role
      # TODO: move to the `from_omniauth` calss method
      @user.update_attribute(:role, params['role']) if params['role']
      sign_in(:user, @user)
      set_flash_message!(:welcome, :success, kind: __callee__.to_s.split('_').first.titleize) if is_navigational_format?
      # We make use of the customizations we do in ahe application controller
      # for how to handle what should happend once the user has signed up
      redirect_to after_sign_in_path_for(@user)
    else
      # Ther are corner cases where this moght not work, so we need to know
      # where to go from here
      session["devise.#{__callee__.to_s.split('_')}_data"] = resquest.env('omniauth.auth')
      redirect_to new_user_registration_path(tab: :sign_in) 
    end
  end
  [:facebook, :google_oauth2].each do |provider|
    alias_method provider, :all
  end
end

