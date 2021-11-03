class Api::OmniauthCallbacksController < DeviseTokenAuth::ApplicationController

  def all
    @user = User.from_omniauth(request.env['omniauth.auth'])
    params = request.env["omniauth.params"]
    I18n.locale = params["locale"]
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
  

  def failure
    redirect_to root_path, notice: 'That did not work!'
  end

end
