class ServiceRequests::IndexSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :details, :state, :image
  has_many :categories, serializer: Categories::ShowSerializer

  def image
    if Rails.env.test?
      rails_blob_url(object.images.first)
    else
      object&.images&.first&.service_url(expires_in: 1.hour, disposition: 'inline')
    end
  end
end
