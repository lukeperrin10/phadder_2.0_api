class Users::ForServiceRequestSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :display_name, :avatar, :email

  def avatar
    if Rails.env.test?
      rails_blob_url(object.avatar)
    else
      object&.avatar&.service_url(expires_in: 1.hour, disposition: 'inline')
    end
  end
end
