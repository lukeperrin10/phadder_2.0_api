class Api::OmniAuthCallbacksController < DeviseTokenAuth::ApplicationController


  def omniauth_success
    if end_user?
      render_data_or_redirect('authFailure', {error: 'User is not authorized'})
    else   
      binding.pry 
      #get_resource_from_auth_hash
      #set_token_on_resource
     # create_auth_params
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


end

