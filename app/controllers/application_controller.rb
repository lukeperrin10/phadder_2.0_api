class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception

  def handle_exception
    # $!  Ruby global variable for latest error message
    status = ActionDispatch::ExceptionWrapper.status_code_for_exception($ERROR_INFO.class.name)

    render json: { message: $ERROR_INFO.message }, status: status
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role first_name last_name])
  end
end
