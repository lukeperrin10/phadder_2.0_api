class Users::ShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :avatar, :display_name
  belongs_to :service_provider, serializer: ServiceProviders::ForUserSerializer

  def avatar
    if Rails.env.test?
      rails_blob_url(object.avatar)
    else
      object&.avatar&.service_url(expires_in: 1.hour, disposition: 'inline')
    end
  end
end
